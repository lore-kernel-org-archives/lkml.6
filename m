Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFCDC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EF72082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd+t3DCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EF72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeJ3E2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:28:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44364 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeJ3E2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:28:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so493519lji.11;
        Mon, 29 Oct 2018 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h1PSpKFhM/c13yO/3T6JehFSkveyYZNOUjmeXVDXgzc=;
        b=sd+t3DCnvQ3jblhTjkmEY5nm/hRqFWsD9oyY8VQE/7O8qmD3Z2b6q3JNhahYrSbXlJ
         eQg3NeYQpoH4dBLLJ+cGW9t9DbPilfeNslCXYaBmKs/EwNXwrGrwBTu2Vz8kW/3Q8lfv
         a0PoAloTIMEPi7bWYjrugyU/WXi77sHsbAoK+UNuwT4QJcBi1Pa7Lj8/oVTn+JxIfifG
         7wkrV4TMYK10Btdm/tKyq3AwYcwTYzfXefl5aFCjzramFMsvR6Xpz+HtfAG4vQDUNxyv
         f42zBIgpwSaZNnr2dSF0GiVOctZQ4VKWFgodRJdGpIvUc482nslhdxe7xLIUAOxMotiz
         /0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h1PSpKFhM/c13yO/3T6JehFSkveyYZNOUjmeXVDXgzc=;
        b=APq7qS+hL59niQgdbl4E/M1Uezb4gE5+51a96qOqfZ58nsgE47jlSivpeCt5wsHQCq
         8B8SJx8CVNKNW+AUpOO6h/+RABQ0TxksG48xAmJ1jt13GT7HTgixVvKckSJyGQujESGa
         Nrcc0baUA77Q1NUqROAg4WV5JPmu8daih4ozRp/OjHRW5LD/wek/GueTMueYQDihi+oC
         ZDN0qpxr1ChAzFAB9PlzQuZFgYnoQUGTLHjY8FhjAKkcmO0GURzfgO9Ez24IwJCK1J4c
         LrSR727EBREg3FNz6BskOHUVNRUUMK4yhVW8TL2XlnqN/7vXNRLDanevfpsV/D6MdZHq
         WE4g==
X-Gm-Message-State: AGRZ1gIou7TvPFuV08p9BdNzNuUnQo+G1AL5Bf95ThzOZrfvHgus5y7t
        7lHzZgk7RrOJRyFL7NW6e95tN/FUlmA=
X-Google-Smtp-Source: AJdET5dBgF3dlQSkx3UZO65y3Iipf2/i1ACbombNnhJiAVgrYmqF0MLrMGRJdBircBlOtX/JDeAqqQ==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr9967251ljd.129.1540841884807;
        Mon, 29 Oct 2018 12:38:04 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id k14-v6sm1840775ljh.65.2018.10.29.12.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:38:04 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <20181026090518.6f3c064e@lwn.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <260ebcde-9219-693f-a6f0-2f56f30fe8bf@gmail.com>
Date:   Mon, 29 Oct 2018 21:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026090518.6f3c064e@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2018 16:05, Jonathan Corbet wrote:
> But
> could I ask you, please, to make a pass over it and reduce the markup to
> a minimum?  Using lists as suggested by Markus would help here.

sure, it's even easier for me to maintain the doc :-)
as i just wrote in a related reply, it might be worth having checkpatch 
to detect formatting constructs that are not welcome

--
igor
