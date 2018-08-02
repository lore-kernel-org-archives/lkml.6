Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29B6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9344820894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrsVWytv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9344820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHBFbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:31:45 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40030 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHBFbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:31:45 -0400
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so852641qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 20:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vlF99zIYNDXmbzEvrhdaIjZFdCwXRQIabAo3+hDcjoM=;
        b=NrsVWytvdSH6UR/ia8BMYL81H6FiXIZ7DFNeGPwc+wgC9uWPmdWgQ+v0xnSGCxxtdH
         bh1rDCK2raKsjcEEj9/+0mCB0gM8nfdohiIBa+jPwVzgeGXGyV4IG92oVKDb1mQcfylt
         25W/eOc/QPKMMwg0GrwxFWQByxcB6kHPhYz+ItstnSQGYz6tXAMqkgv6owXE83crEuo1
         coazJTRkq7k5G+lcgVe4QjS5vE48lzXcCTKJVQBeg5JVHvpU1H3VRXsnc16w/LKy8FMU
         sM/CBiboSQ9O7QElxjoI2HYMWXcEDb0UEXo+8e5mnGYtlMcFtINPqw5zzS1SI9pGa3dO
         OR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vlF99zIYNDXmbzEvrhdaIjZFdCwXRQIabAo3+hDcjoM=;
        b=FknaE/vdsbzIAcXJsZwLMKKFXtpa/2mnN6/dDMWP8iWu3XiLkAklA5z8G1CAyxtdaW
         I+gw3nVpEzaEUKT3ajDUGUM1ovUrgYl4K+nxC8/aCehU3Ru81HMS984R297TksFJ5kFr
         f2aRKfb4/76NS4cj/QJMeET2PVmb5gSJ9Egg5qLVaM09BA6JVEWrjGIIiVHxAANXF849
         2FLPyWER4utd4Bhfs7Zt5nIxlYhOom0yTPRHEYtAnfV0kXj9z02KUmNj8c+gkxXS0xXO
         zfFHjwUMqBNGU5qYaxiqSwrLV0aAXkUu3XEbo33q5ao3N/7rgwJqOqvIa0FDiLyLE5pj
         l3hQ==
X-Gm-Message-State: AOUpUlFZ/wJaZF9hBfd4RdKL3B+hQXPMOZ9FgkH03Pj2SKP2n+umEeEx
        7FqysvbD9uCpVpkL2tZrMZy/FXt5c7nxFuePcE4=
X-Google-Smtp-Source: AAOMgpfNAXTcMwwXqes+heszSzOIq1LE6ljOysEcsB0PrrFXOJFe1O92NDkkt/Ho48XmzioqEpTMjxrbJCz5iZNoFx4=
X-Received: by 2002:ac8:31d0:: with SMTP id i16-v6mr1068034qte.12.1533181361483;
 Wed, 01 Aug 2018 20:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
 <20180801114518.ajkgsx7exjny63mt@mwanda> <CALtPoQCyoe5V0m5=3K1XeZm41aDCaJ0rmYU-a=qkm=Yb8jgMxg@mail.gmail.com>
In-Reply-To: <CALtPoQCyoe5V0m5=3K1XeZm41aDCaJ0rmYU-a=qkm=Yb8jgMxg@mail.gmail.com>
From:   Jheng-Jhong Wu <goodwater.wu@gmail.com>
Date:   Thu, 2 Aug 2018 11:42:30 +0800
Message-ID: <CALtPoQA7EdUDmN26Z406J6gFFx4XLUy1zTb65x8MgTVpoG57tg@mail.gmail.com>
Subject: Re: [PATCH] staging: mt29f_spinand: fix memory leak while programming pages
To:     dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBEYW4sDQoNCkkga25vdyB3aGF0IHlvdSB3cm90ZSwgYnV0IGJlZm9yZSB0aGUgc3BpbmFu
ZCBkZXZpY2UgaXMgcmVtb3ZlZCBhbmQNCmZyZWVkIG1lbW9yeSBhdXRvbWF0aWNhbGx5LCBwcm9n
cmFtbWluZyBwYWdlcyBtYXkgZG8gbWFueSBtYW55IHRpbWVzLg0KQXNzdW1lIHdlIGVyYXNlIGFu
ZCByZXdyaXRlIGEgbGFyZ2UgcGFydCBvZiB0aGUgZmxhc2gsIHRoZW4NCnNwaW5hbmRfcHJvZ3Jh
bV9wYWdlKCkgbWlnaHQgZXhoYXVzdCBtZW1vcnkgaWYgbWVtb3J5IGlzIG5vdCBsYXJnZQ0KZW5v
dWdoLg0KSW4gZmFjdCwgT09NIGluZGVlZCBvY2N1cmVkIHdoZW4gSSB0ZXN0ZWQgcHJvZ3JhbW1p
bmcgbXVsdGktcGFnZXMgYnkNCm10ZF9kZWJ1ZyB0b29sLg0KSWYgT09NIHdhcyBub3QgY2F1c2Vk
IGJ5IGRldm1fa3phbGxvYygpIGluIHNwaW5hbmRfcHJvZ3JhbV9wYWdlKCksDQp3aGF0IG1heSBl
eGhhdXN0IG1lbW9yeT8NCg0KQmVzdCBSZWdhcmRzLA0K4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSADQpKaGVu
Zy1KaG9uZyBXdSAoVmljdG9yIFd1KQ0KRS1tYWlsOiBnb29kd2F0ZXIud3VAZ21haWwuY29tDQri
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIANCg==
