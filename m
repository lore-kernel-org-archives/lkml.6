Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A9A2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzeYz4Jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A9A2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbeKFHRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:17:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35117 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbeKFHQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:16:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id n4-v6so5114515plp.2;
        Mon, 05 Nov 2018 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dTx0MyxMvJWBg5FgKXcvGw8UE6R9YlJFE4cTpyv6Hk0=;
        b=OzeYz4Jn507e8ZnCNYLV3fbItQs7vbYXycLbt7GelK6MRcmWh7L28Waz0WMcTHqngb
         4KMQEflM8ui/OQgikeGlmPfaQYsm/fHRsdsynhUbm85ssHV2LWdbuGrfBcjY1HUdnL8u
         S5h3l83dDuXKVBSS4IcYROGZSGez1UJJ3SVN1OCnkpxiv81JxQfnnjI6SnInSs4r1H2a
         kpe+dcgNEDsfbXGwDhhMx/EcMP57ZCpaqXQRIstwyQKfXgBa3vz6qa+nmL3w0W8waERJ
         BQkvVhBpFXJTPivAhBdFEThafvjjW6DVWtj5riy2DZuvtzztGlwLI7lSxIIhaFNqtAot
         Lo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dTx0MyxMvJWBg5FgKXcvGw8UE6R9YlJFE4cTpyv6Hk0=;
        b=bjgGrdKMPsayNC8/GSkWgl/Ygg3aqxi62iYnQPeBBnsb78zuG2PrV2nBfDolssVVgO
         kQEH8gZ1UTSKc8qulK9X0dJ3XRC2neecBTue+3ZdxGwgFXZg49pueQHcNFWUPM6riTAv
         xgDJMP7JvKQi1OmoMAlVVjz44GOxHODjLHTxrEcdwNIPolp8NS9CNIrBfIVAUC6QnM9x
         H+y3NBLBKWzRBOXRbDoeGcfpqI/WD1TcLuFl1x/WtxZQ2XZz4rKGvLizTMlHfKCl4rXy
         zSVTgmuVGwXXuTgslai764UfvFpR7HdOy7o+06cNLB2RyHJ6d7pE1KZJZZkF5wiEuAZO
         lUwA==
X-Gm-Message-State: AGRZ1gLwYrlxFNUY96EX5NydciolYtSDYruW4co8XTj2yMeqZWEKGjah
        EKDI9+y7b22J1azhvWtEUe0=
X-Google-Smtp-Source: AJdET5fsEio7H+3d9hnXIjkpWArjkCv+s50ekmErvJfDcFyC+4UUHM2UczKdGNNikG1Icoy63QLOPg==
X-Received: by 2002:a17:902:bc8c:: with SMTP id bb12-v6mr22797774plb.275.1541454912854;
        Mon, 05 Nov 2018 13:55:12 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f193-v6sm53474546pfc.74.2018.11.05.13.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:55:12 -0800 (PST)
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
Date:   Mon, 5 Nov 2018 13:55:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, Ben, Paul,

Do you know if anyone has tried this series on PowerPC?

Thanks,

-Frank


On 11/5/18 11:24 AM, Rob Herring wrote:
> On Mon, Nov 5, 2018 at 9:26 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add checks to (1) overlay apply process and (2) memory freeing
>> triggered by overlay release.  The checks are intended to detect
>> possible memory leaks and invalid overlays.
>>
>> The checks revealed bugs in existing code.  Fixed the bugs.
>>
>> While fixing bugs, noted other issues, which are fixed in
>> separate patches.
>>
>> *****  Powerpc folks: I was not able to test the patches that
>> *****  directly impact Powerpc systems that use dynamic
>> *****  devicetree.  Please review that code carefully and
>> *****  test.  The specific patches are: 03/16, 04/16, 07/16
> 
> I'm waiting for this to happen. Send me a pull req when it does or
> when you give up waiting for a response.
> 
> Rob
> 

