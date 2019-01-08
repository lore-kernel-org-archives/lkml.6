Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9411C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793762173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf6V/MtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfAHBJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:09:43 -0500
Received: from mail-yb1-f172.google.com ([209.85.219.172]:44693 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfAHBJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:09:42 -0500
Received: by mail-yb1-f172.google.com with SMTP id e1so933661ybn.11;
        Mon, 07 Jan 2019 17:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KgDAscc+FGdRDhmp9pxRPHEyXet/ItuB3TcRw/U/N9A=;
        b=pf6V/MtC4gVIJKHs9n5v5hgzOebeEa39zTuf6bGsUpJttDe4zrT/nY2P3EtoaX7TGa
         4oFVreXYWEJzLDsprAo4m13NFMTlGh1f0VGC4Xs3I6c48WMldVDuLGboRrv4u03EYu7T
         JiFyqyHG+Dv/uEQGkocZTiGko9GdECTyXScU+8ko0Qvd8c6Vj7mlQ3nlH1S/cmB8F+Gm
         gItUXXBr7zUgy6985IwjVW/L3Rk5FEfltoBgOU5pxv1BqYBqJIu1nW/nVGFps3XPBwsO
         /LdKmtO/aj0jjXRPKsXfmq1xw/JWD8PD5lUxvJzLFNhlRNHQP+l14klSNMzUJLx31A0y
         s31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KgDAscc+FGdRDhmp9pxRPHEyXet/ItuB3TcRw/U/N9A=;
        b=LbVsZitbPcIXtfCJLXXIE3FImYAzyVRcVXgXEliUyDjTb+nIMl0Eo2wxuixynswDqD
         zUL7ilgMJGQpqeurfeD9braJLxjUZBrLiN++8zcZhkUBH1O6Tt1LFXEEDwjMf73bbdnP
         ydiRDfstFIPBySa4yXkfLG5AIjzY/92oGhLXfDUR8JyGlJYjWfYjImQ4Y8fYF+pi68Mr
         9DeU/4i7LQXpGKLg9apEBemBWtn+gnc8FWg98TATRnbcl31bgOBDvtMcl4cSdU/cyFRD
         x4gpHOEViqGeGlTSNw8qUfyCQmozq8GXk3MRGKdEPsLyWbOX5TVEcuf40Q8ca7X2q+n4
         Lbfg==
X-Gm-Message-State: AJcUukcyVF7EnVtisSSi6eLmtK1+xF2CpQN8dsbM2e+Fz4gn8IV8nAxF
        4b6RkrENSz6gjZsz7h3oOpk=
X-Google-Smtp-Source: ALg8bN4+k7EX/I9Z1gVONay48BsoWIoXcodIq5k5ZW3FdtujwtN2vjkA/mAwzqzlZxU+Xexb4I2r7g==
X-Received: by 2002:a25:7797:: with SMTP id s145mr60323867ybc.477.1546909781773;
        Mon, 07 Jan 2019 17:09:41 -0800 (PST)
Received: from [192.168.1.138] (cpe-24-160-118-96.tampabay.res.rr.com. [24.160.118.96])
        by smtp.gmail.com with ESMTPSA id g84sm26174823ywg.9.2019.01.07.17.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:09:41 -0800 (PST)
Subject: Re: Consistent capitalization of "device tree"?
To:     Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     devicetree@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20190107183711.GA5671@amd>
 <CAL_JsqKzs4WoJoe_uCzhS3NBGfHiTQ96GkfSRhtxeah0THoVyw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4d4cf1b1-0966-305d-9bf3-e9dc84d6e8c6@gmail.com>
Date:   Mon, 7 Jan 2019 17:09:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKzs4WoJoe_uCzhS3NBGfHiTQ96GkfSRhtxeah0THoVyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 10:45 AM, Rob Herring wrote:
> On Mon, Jan 7, 2019 at 12:37 PM Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Is it "Device Tree" or "device tree"?
>>
>>  pavel@duo:/data/l/k/Documentation$ grep -r "Device Tree"  | wc -l
>>  235
>>  pavel@duo:/data/l/k/Documentation$ grep -r "device tree"  | wc -l
>>  595
>>
>> I guess it would be nice to make it consistent. I guess "device tree"
>> is preffered?
> 
> Well, the spec uses "devicetree" with capital 'D' as needed (titles
> and start of sentences). I didn't check if we're 100% consistent
> there.

For reference, the specification is at:

https://www.devicetree.org/specifications/


> 
>> Should we do something like this?
> 
> I'll take patches, but it wouldn't be at the top of my list.
> 
> Rob
> 

