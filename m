Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F6C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9251D2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAox2x2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9251D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeJ3Eaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:30:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41777 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeJ3Eaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:30:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so2956213ljb.8;
        Mon, 29 Oct 2018 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f/1zgO6QY9dsdwTFWvdeZJ8nH6l3UbQTekXe/s6WAV0=;
        b=eAox2x2iNNxHDRnRdRNmP8X0ETMgjCAen0U9xGP28w0OMB51Ep/QHAmR12E+ifjcU1
         0T69OWZ2MttkREOyzS60b7Gy/daDI2ZR+ByVdvHY9s3tRjAYRwpGir5V62C2sGAETPl7
         xRbbbmwQItKPUqZ2OMLp5YtuIB+YSn+zoL6at5lsvMk9wnTHR54xlPMVNDk4y/mRtcEP
         McGTnnjllEkGAeveRK9kjtWrae6SGi1HeUNz97YWP7DFsaNBdNGtyjbbXTOJ5VV4MtRU
         GdDpBZhqxE05TlaJSDPKG6PJlnQJn+jq3LWf9Mos/S3QYGeRUt3CeDcrC3bNcTu38FiB
         gW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/1zgO6QY9dsdwTFWvdeZJ8nH6l3UbQTekXe/s6WAV0=;
        b=T259+VrdRyKZQ27p0wg0J0iseQhz/HVflc01yiUCNmxrUJ7oAd3DIB9HTheJgYT4n5
         fz9fYVEis73KaGbFp2eD2Fjph/5VBur6UxyVyqxA06o3HW79D2TC1kusqnYis/1Rsad8
         hyuqmdi4jRqI+LSm9aRid5jHhfMfZEZTb6dNquunoKAnJroKFK3YAynzQJXahnl85KG3
         RwZtHff68bRxOgs4RKliW7vqQ5Nxy9vCLSGLSjzP08d2wXBezlCvagWCfV9PFQhwLR6Y
         ekiOvYHKVoWDW8ZJq7Wzf/CXT2v8TQhBileVwD1CZa4R7WaNRuzdlNUBAYcoJb0FbtO9
         Swtg==
X-Gm-Message-State: AGRZ1gK4MxJk0O7Pi/Nzc6oimHYBf8fSvDQORBFV219UO85mWc50uKI7
        /UfuozX5K9qcKOW/Qb0PlqLfX5jJifM=
X-Google-Smtp-Source: AJdET5eYwcVGzjYYT6qFS0SGnCIzSeVLDA37Ji2cn90DUfYw6p1hdSkKNbCMIWvvKEQe4Fm+TNERbQ==
X-Received: by 2002:a2e:809a:: with SMTP id i26-v6mr8788703ljg.100.1540842030457;
        Mon, 29 Oct 2018 12:40:30 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id m13-v6sm22426ljg.56.2018.10.29.12.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:40:29 -0700 (PDT)
Subject: Re: [PATCH 13/17] prmem: linked list: disable layout randomization
To:     Alexey Dobriyan <adobriyan@gmail.com>
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
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Lihao Liang <lianglihao@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-14-igor.stoppa@huawei.com> <20181024134343.GA7767@avx2>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <47d5706b-12b9-a94f-d668-8e9a659e33d0@gmail.com>
Date:   Mon, 29 Oct 2018 21:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024134343.GA7767@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2018 14:43, Alexey Dobriyan wrote:
> On Wed, Oct 24, 2018 at 12:35:00AM +0300, Igor Stoppa wrote:
>> Some of the data structures used in list management are composed by two
>> pointers. Since the kernel is now configured by default to randomize the
>> layout of data structures soleley composed by pointers,
> 
> Isn't this true for function pointers?

Yes, you are right.
Thanks for pointing this out.

I can drop this patch.

--
igor
