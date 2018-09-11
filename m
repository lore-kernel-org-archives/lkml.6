Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319F120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwz6ucYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319F120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeIKS7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:59:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33245 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKS7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:59:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so12333221pgc.0;
        Tue, 11 Sep 2018 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nbtgpP2T8od8fNda3iV2RfUdGjOQ4CKRuBIj6haq37w=;
        b=Mwz6ucYewn6kPOKBEwFT4xQKYhqMUggnpnch8i9WnzF1zOWbKUgUVMz2UaGSBIyEMe
         1LQYRK8SpL87UWjWobyLkFjZxQIgtBnK/X2qghHJ1voAcNKLJhZTPprjhHpmqe8QUv5M
         CcvJoP+J/RuzQDKMr75DR4+oBJLRBBXu6DzjK9DyG3/Bgx1GNxlu/3HDr9tHDo7Pynuh
         nAchgo+G7L3L0oQI3e1wVtTIKkaSLgGq0hx4Q8g9uM7+hqiP7rhK8IMFMDJ/bVSqZWK7
         PlVEGhNd+gNBPWDMjRrRyxPPrKymsd/ffU7FPqBLvsF/80b/ZhGDJQv6PX45ptgHcVBE
         oxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbtgpP2T8od8fNda3iV2RfUdGjOQ4CKRuBIj6haq37w=;
        b=REbUgKfdIfvjDp/3U14iz+TSlHdQRilijLIorx9clHti5XQLGzP9QJb1CTMQ/CAVng
         wPOke4kkWSLW5gnrw1OVza4k9Ey6c5YM4bm2Ds9R8Q0fS4XUUzlSRIpPn2XHyOaWOOcM
         M/x2Tb7ViXPnrhNKovkNGXrfQI8QPyYGGi5A9uE96TfD+AGZA8Envn4M62uVYt3+xzTL
         C4cRUD9IrJ1R/h0oAnlAc2zfm5UcOREvpUcosAVXBXidffZn8/2VtkPatzfzMPOkz039
         pOKl8bP+chS3lwTODD5DsENvlP9r8VfZXbguU+lD9X4QxBGJpsSeWXvPJtoZbwo+Ob4S
         YsJw==
X-Gm-Message-State: APzg51BQ9wl5KWIChpOq4bjNEm3cnwRALcVAXVlewn9kH2lem+dbrNlT
        qgXJAI7I3guaMSzxgkNU/GyW1CIY
X-Google-Smtp-Source: ANB0VdaQBXdf577MBfpG07S+4GVbQ3b7dlQ2kvgeidgQ8W1x4/hWETMp2LEI5q8Tn/ReNLANJBM/Sg==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr29662727pfb.20.1536674419675;
        Tue, 11 Sep 2018 07:00:19 -0700 (PDT)
Received: from [192.168.1.5] ([110.77.230.212])
        by smtp.googlemail.com with ESMTPSA id f75-v6sm36723078pfk.85.2018.09.11.07.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 07:00:19 -0700 (PDT)
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
To:     Kristian Evensen <kristian.evensen@gmail.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
 <20180910103022.GR1089@localhost>
 <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
Date:   Tue, 11 Sep 2018 21:00:15 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/2018 18:39, Kristian Evensen wrote:
> Hi,
> 
> On Mon, Sep 10, 2018 at 12:30 PM Johan Hovold <johan@kernel.org> wrote:
>> Please provide the output of usb-devices (or lsusb -v) for both
>> "configurations". How do you update the configuration by the way?
> 
> The configuration is updated using a proprietary AT-command
> (AT+QCFG="usbcfg"). The format of the command is as follows:
> AT+QCFG="usbcfg",<vid>,<pid>,<diag>,<nmea>,<at_port>,<modem>,<rmnet>,<adb>.
> In other words, you set which interfaces to enable/disable. Based on
> my testing, it is only possible to enable/disable diag, rmnet (QMI)
> and adb, as well as nmea, at_port and modem together. I.e., it is not
> possible to only disable for example nmea.
> 

> If I for example disable diag, then the bInterfaceNumber of nmea
> changes from 1 to 0, at from 2 to 1, etc., etc.
> 
> BR,
> Kristian
>

This also becomes a mess for the qmi-wwan driver which has the rmnet/qmi 
interface hardcoded to 4 so that driver will also need a workaround.
Quectel seems to have completely missed the reason why usb id's should 
be unique and not reused  for a different product or a different 
interface layout, there is already a workaround in qmi-wwan for their 
previous EC-20 card...
My opinion is that the option and qmi-wwan drivers should support EP06 
in the factory delivery configuration and not in a configuration the 
user has selected with a Quectel proprietary AT cmd.
Can you give some good reason for disabling an interface instead of 
letting it stay but not use it if you don't need it?


Thanks
/Lars

