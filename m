Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E8AC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 22:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE51217AF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 22:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kf+OpSEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE51217AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeHEAfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 20:35:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37940 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeHEAfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 20:35:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id t2-v6so3406284edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version;
        bh=TYXu0dnkXvWAoYz6ifv3f+ww706zYPALY5PkAMmetSU=;
        b=kf+OpSEmuhPGUzOLRgV3d+16oMbD4Q+YakGyABpTWFwHQDLCC5HZprzSRbRMejC5C4
         Kg+as/ysvxoYPAU5LZWwFOgV2ToLADdwuxQ6UNHKX7g+yMJDWWT0eg7W0Oqvr2Y3wkiI
         UfphcNGipj/zLrvLqPlZFK0QN7Od59hVo0vKnTl5/Ofuf6HIH+jkobJbagnMj/RbaUex
         m/NtsObS0lS68M49seDlVO9+8ZDkUjgdrzEZj1zWGv87tZIuL1dUsx2vCyT1jEWz2m3d
         5kHAefAWDuW3tARr5PGlOLIfBB2CfRYlx/Lkmki6LJDlsmAjYO9Hw5U9JG6HyiH0l9ri
         6eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version;
        bh=TYXu0dnkXvWAoYz6ifv3f+ww706zYPALY5PkAMmetSU=;
        b=kxej9L2LmPqLem2CiZW6T+IjlzC6qI4P2hOveJRT6DHfhf1+8uaJ3bJ8DrdT3OAJz1
         aqL4cf2Dlxv3B2Rz0sUKlHCvpHmDI75bkKuVkqYsu7sX95CfvYBXMtTH+iClK35YMJ34
         n/NgwmLTIlcwA54HHrUuDXkVH5ygKE4MZkAqMWg5Xvt7RaJfjhgHaVCtxl/y2kjVTHlp
         W+Kurdj7gLvZthPqBV9ROq09J2F4gapsfULGQ2BqnANT/UljYBGqhIHra5K4by9gIutF
         aN52iC48YYst4/LhiyDjYyy/a9bXT1Zju5ZoYtzU1pecS18k1HE9y5Rrvk5n+umPv3UN
         U9ZQ==
X-Gm-Message-State: AOUpUlFwPgxq9MrzhBzzK36RpMg8+LuHElTKLxR9NajzIepFsNUTEkWs
        Tj+AOIEsOl/+ZDK2fXnrbI5VrFvlUTU=
X-Google-Smtp-Source: AAOMgpfBR45TeRJyRBqFp9nkeJXo0KayzxR5uI1YIPx6kzv9566zMnAj4XoSTlpo+GlM8vYyMA4izQ==
X-Received: by 2002:a50:c251:: with SMTP id t17-v6mr12259879edf.108.1533422010262;
        Sat, 04 Aug 2018 15:33:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id x13-v6sm9640666edx.17.2018.08.04.15.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 15:33:29 -0700 (PDT)
Message-ID: <1533422007.2679.141.camel@arista.com>
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
From:   Dmitry Safonov <dima@arista.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org
Date:   Sat, 04 Aug 2018 23:33:27 +0100
In-Reply-To: <20180804180734.GA25546@flashbox>
References: <20180804082702.434482435@linuxfoundation.org>
         <20180804082706.427556290@linuxfoundation.org>
         <20180804180734.GA25546@flashbox>
Content-Type: multipart/mixed; boundary="=-zKF9eMMdzTtDJf+QczBV"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zKF9eMMdzTtDJf+QczBV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2018-08-04 at 11:07 -0700, Nathan Chancellor wrote:
> Hi Greg,

Hi Nathan,

> I am so sorry I didn't catch this in my initial report but this
> commit
> along with ba7aaf93ef2f ("netlink: Don't shift with UB on nlk-
> >ngroups")
> breaks mobile data on both the Pixel 2 XL and OnePlus 6. There is
> signal
> but it just never connects to 3G/LTE. Reverting those two commits
> fixes
> the issue.

Sorry for breaking your use-case,

> Nothing stands out to me in dmesg unfortunately and iven neither
> device
> is running a vanilla kernel, I cannot say if this is a problem in
> mainline
> or not but I just wanted to make you aware of it.

Could you provide the dmesg output for the attached debug diff?

-- 
Thanks,
             Dmitry
--=-zKF9eMMdzTtDJf+QczBV
Content-Disposition: attachment; filename="netlink_groups.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="netlink_groups.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL25ldC9uZXRsaW5rL2FmX25ldGxpbmsuYyBiL25ldC9uZXRsaW5rL2FmX25l
dGxpbmsuYwppbmRleCA3ZDg2MGEyMmU1ZmIuLjBjZGRjMzVlMWU4NyAxMDA2NDQKLS0tIGEvbmV0
L25ldGxpbmsvYWZfbmV0bGluay5jCisrKyBiL25ldC9uZXRsaW5rL2FmX25ldGxpbmsuYwpAQCAt
MTAwOSwxMCArMTAwOSwxNCBAQCBzdGF0aWMgaW50IG5ldGxpbmtfYmluZChzdHJ1Y3Qgc29ja2V0
ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIsCiAJCQlyZXR1cm4gZXJyOwogCX0KIAotCWlm
IChubGstPm5ncm91cHMgPT0gMCkKKwlpZiAobmxrLT5uZ3JvdXBzID09IDApIHsKIAkJZ3JvdXBz
ID0gMDsKLQllbHNlCisJfSBlbHNlIHsKKwkJaWYgKGdyb3VwcyAhPSAoZ3JvdXBzICYgKCgxVUxM
IDw8IG5say0+bmdyb3VwcykgLSAxKSkpCisJCQlwcl9hbGVydCgiJXM6IGdyb3VwczogJSNseCBu
Z3JvdXBzOiAldVxuIiwKKwkJCQljdXJyZW50LT5jb21tLCBncm91cHMsIG5say0+bmdyb3Vwcyk7
CiAJCWdyb3VwcyAmPSAoMVVMTCA8PCBubGstPm5ncm91cHMpIC0gMTsKKwl9CiAKIAlib3VuZCA9
IG5say0+Ym91bmQ7CiAJaWYgKGJvdW5kKSB7Cg==


--=-zKF9eMMdzTtDJf+QczBV--

