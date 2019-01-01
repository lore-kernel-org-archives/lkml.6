Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF28CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 02:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFF221019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 02:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXUpmw2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfAACRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 21:17:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41990 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfAACRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 21:17:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so24393421otk.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 18:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=8zBMzzrjp6pG7SSfjJAIVvtSuHboBPvxXpBOxFTs9jw=;
        b=jXUpmw2DCizpkv/j97JxvUcJ/agmBghU55fCRhAn4rSX6kOylXYX36QHkNTqgrGUj2
         TldSuHrqEG5PcYKyNLx8IuTjvnCZm71Eh9D4EyC2GgeiwAor0c1S+PFrjufwSFvcfVG3
         WtOV+l5gHJqQ6rIKErv498z3grz0SanKROzfFIBKMwABxAyeLxN9xl+nDD6MFtNuokzX
         n/XoHPFZ4fDhTQ2VJuhy74TY1Bed5n7A0sPiSyAV4W1x9DzN8eDYg+hXw6iZGUOqIVWr
         sLy368AddA7M3+Qw6dYv/txZbMihdNg0Pn7CY7jMDIPXvRIOKE6z3NTpYPm7qDtyzJ8f
         vDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language;
        bh=8zBMzzrjp6pG7SSfjJAIVvtSuHboBPvxXpBOxFTs9jw=;
        b=BVQGwt73xC9lGv4/tE1PTF0A68PFFgY+v5NsiGjaIFURP4a0828De0+kOry6wjbOnD
         CD8arHOaPi4Arn8LX/HIvADMrlQk5BI9z/rtTJL9r246T7NdcG5FhGo5/4hsPHPI7rWZ
         FBU2TXpmcSBn11NzTCkYGrIc9FmC0kpxtZt7D/V0pkrQEWil8CQtcqS5SmPlloW2RMvb
         taZ4zaNwLjLvvzq+SmUaMGEqUN/lmwobxQr9DfxocXc7C7eyYEX35ROAPqc1qSrrAH+W
         XZa3wtPKWEQH6KeJl6PX5Qo2+Elny2Lhn8CqljfLR9YMiUIWwHl03eEEXh8mY/CtJyrk
         beEg==
X-Gm-Message-State: AJcUukdKAPbW9mOO1IpPtAfMdLuDaSi5vo68mu/l7+Fw/AaeGTrd/9Iq
        iTeUbf5jPsP3uvIfRMVghVCujG+O
X-Google-Smtp-Source: ALg8bN6O7Jiry+EhhCN/rA3mqHj7EzyGp7j2EFaMZaZBhtukEQW0L2yoAKuBzu8gkB87k/NdAsk2qA==
X-Received: by 2002:a9d:f44:: with SMTP id 62mr27996238ott.182.1546309065493;
        Mon, 31 Dec 2018 18:17:45 -0800 (PST)
Received: from [192.168.1.102] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id l16sm23147889otr.13.2018.12.31.18.17.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 18:17:44 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     insafonov@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181230183918.3888-1-straube.linux@gmail.com>
Message-ID: <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
Date:   Mon, 31 Dec 2018 20:17:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181230183918.3888-1-straube.linux@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------C1422955F8BE8DEFEB2CF955"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C1422955F8BE8DEFEB2CF955
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/18 12:39 PM, Michael Straube wrote:
> Commit 6bd082af7e36 ("staging:r8188eu: use lib80211 CCMP decrypt")
> is causing hardfreeze whenever the driver tries to connect to my wifi
> network. That makes the driver unusable on my system. Reverting the
> commit fixes the issue and the driver works properly.
> 
> Dec 29 19:21:17 gentoo kernel: BUG: scheduling while atomic: swapper/6/0/0x00000100

Michael,

I have verified the freezes that you see. Although I have not been able to 
capture the console dump, I think we are likely seeing the same problem.

I do have a work-around in that I have not gotten any freezes when I force 
module lib80211_crypt_ccmp to be loaded before I load module r8188eu. This clue 
was used in finding what seems to be a good fix.

I do not know anything about demand loading of modules using 
try_then_request_module(); however, I noticed that the macro actually calls 
__request_module(), which has the following comment:

  * Load a module using the user mode module loader. The function returns
  * zero on success or a negative errno code or positive exit code from
  * "modprobe" on failure. Note that a successful module load does not mean
  * the module did not then unload and exit on an error of its own. Callers
  * must check that the service they requested is now available not blindly
  * invoke it.

I note that it says "user mode module loader". Routine rtw_aes_decrypt() is 
likely inside some sort of locking, which leads to the "scheduling while atomic" 
bug that you see. As a result, I suspect that the module is not loaded, and that 
leads to the NULL dereference when the module is accessed. Please try the 
one-line patch attached, which forces lib80211 to load when r8188eu is loaded. 
With this patch, I have been connected to an AES-encrypted AP for nearly 3 hours 
with no problems.

Larry



--------------C1422955F8BE8DEFEB2CF955
Content-Type: text/plain; charset=UTF-8;
 name="patch_8188eu"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch_8188eu"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4MTg4ZXUvY29yZS9ydHdfc2VjdXJp
dHkuYyBiL2RyaXZlcnMvc3RhZ2luZy9ydGw4MTg4ZXUvY29yZS9ydHdfc2VjdXJpdHkuYwpp
bmRleCBmNzQwNzYzMmU4MGIuLjA1MjY1NmEyMjgyMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9z
dGFnaW5nL3J0bDgxODhldS9jb3JlL3J0d19zZWN1cml0eS5jCisrKyBiL2RyaXZlcnMvc3Rh
Z2luZy9ydGw4MTg4ZXUvY29yZS9ydHdfc2VjdXJpdHkuYwpAQCAtMTI5MSw3ICsxMjkxLDcg
QEAgdTMyIHJ0d19hZXNfZGVjcnlwdChzdHJ1Y3QgYWRhcHRlciAqcGFkYXB0ZXIsIHU4ICpw
cmVjdmZyYW1lKQogCQkJc3RydWN0IHNrX2J1ZmYgKnNrYiA9ICgoc3RydWN0IHJlY3ZfZnJh
bWUgKilwcmVjdmZyYW1lKS0+cGt0OwogCQkJdm9pZCAqY3J5cHRvX3ByaXZhdGUgPSBOVUxM
OwogCQkJdTggKmtleSwgKnBmcmFtZSA9IHNrYi0+ZGF0YTsKLQkJCXN0cnVjdCBsaWI4MDIx
MV9jcnlwdG9fb3BzICpjcnlwdG9fb3BzID0gdHJ5X3RoZW5fcmVxdWVzdF9tb2R1bGUobGli
ODAyMTFfZ2V0X2NyeXB0b19vcHMoIkNDTVAiKSwgImxpYjgwMjExX2NyeXB0X2NjbXAiKTsK
KwkJCXN0cnVjdCBsaWI4MDIxMV9jcnlwdG9fb3BzICpjcnlwdG9fb3BzID0gbGliODAyMTFf
Z2V0X2NyeXB0b19vcHMoIkNDTVAiKTsKIAkJCXN0cnVjdCBzZWN1cml0eV9wcml2ICpwc2Vj
dXJpdHlwcml2ID0gJnBhZGFwdGVyLT5zZWN1cml0eXByaXY7CiAJCQljaGFyIGl2WzhdLCBp
Y3ZbOF07CiAK
--------------C1422955F8BE8DEFEB2CF955--
