Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0882C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBF92086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHSa1eST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBF92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeFQFyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:54:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32806 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbeFQFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:54:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id y20-v6so20089769lfy.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 22:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vvozap24lsAEalOTtOb5dbJUEIB3GGc/BH80h7TFWeI=;
        b=RHSa1eST+AoXVznHFsK/fPI3qL1Fd5Sjyg+4csMykgwc2UG/6Gzcka+Hl6bpRpF+9+
         yqsToLg0wfSv2KLQL6DC7lv832xDEl2m51Msiqq+ixnFc4DAnnrzWHs0LnBHL7HYAsY9
         ybscCtisfpuLzKAOdZnrtDvd3kbTmHex13QVlqPLez0lmxWTa/9n+eMWBY8rsSTHipwy
         Rk6ngFiWNCHWgJoW7Om8e3msZuC7W/8eSQCwBhP7xnu6r8OFqZTHkF6vBCOBIRkN+iPs
         lcUUJnmUvdjwEDXxSCAK7Qv2tUTnWwHJyfRr5FqWMPwBYZ08wCG2Bx6eKVH/KA+R8jiU
         uz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vvozap24lsAEalOTtOb5dbJUEIB3GGc/BH80h7TFWeI=;
        b=Cvg8rDFzyQzqQFDF8f6Z9GtzRWFtQUbZoPw2GJ1EXRxlzspW2bEb9oHuKO76BrNbrq
         /LRUzxgjvG1lE8Uxfj8AZZT38xIQNwvcnJs0n3jSszNNIhRbyzySVb/7cYAWyQg64+YV
         DdP9rHFR2p3twpmhi29X4W/0mYFiNRFXDmwI50RBLQ/6Y7A035xvr7w7y1uEjGszyFaq
         wTglHJAidOiG0Vs2ukyh02bU3gcma4KgvAzbKtT52J6fpQqTMTeeEozMeZNgYE/DSBtG
         aUaHn46vIVw/ObM6NU8DEC5t2Vp9kUZW6QdkEarc+7qMgt+F1ALbNLJlUoU3l0R2R1ry
         CfdQ==
X-Gm-Message-State: APt69E0WuWyG66Owp8xgHc/ssmpqD/isFbzvSz9jOFE957XOUkO729AC
        jZ8ztULsaLNI6fmmGIYo8u6vCFcol+MqmgqV1sU=
X-Google-Smtp-Source: ADUXVKJpWs4k3GpIELWs+vLmJvA3jUZPMOkcRSBPxSXjMMHw3RFh4Ukp/Ez44KT6fTypBUKq8yJxN9zNJfn/qVe8PL4=
X-Received: by 2002:a2e:93c9:: with SMTP id p9-v6mr5244581ljh.117.1529214875725;
 Sat, 16 Jun 2018 22:54:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 22:54:34
 -0700 (PDT)
In-Reply-To: <CAFqt6zbyCvknqkwnhQiyY1j32zufVk0rkPfxgKbytZcXY=xTVQ@mail.gmail.com>
References: <20180417141547.GA30799@jordon-HP-15-Notebook-PC>
 <CAFqt6zYFxJPMbcyLbJp6qrRDmcy4A+KAk9NhEvy-kVMBL2dySg@mail.gmail.com>
 <20180502135839.5ujlwpirizy2zyod@um.fi.intel.com> <CAFqt6zbSuVZjH0W6o7fMLpytk28y_4tZ7Mt1B36SX=+LkaUP3A@mail.gmail.com>
 <CAFqt6zbyCvknqkwnhQiyY1j32zufVk0rkPfxgKbytZcXY=xTVQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 17 Jun 2018 11:24:34 +0530
Message-ID: <CAFqt6zZQ0qTMDbrBQ3DphCzgxPmm0sH62Z_kU8zK6CT7uzjs9A@mail.gmail.com>
Subject: Re: [PATCH] hwtracing: intel_th: Change return type to vm_fault_t
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 7:32 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On 02-May-2018 7:28 PM, "Alexander Shishkin"
> <alexander.shishkin@linux.intel.com> wrote:
>>
>> On Wed, May 02, 2018 at 11:14:48AM +0530, Souptick Joarder wrote:
>> > Any comment for this patch ?
>>
>> Looks good, I'm queuing this one for the next merge window.
>>

This patch is not merged in 4.18-rc-1.
