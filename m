Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-161729-1520216585-2-6063892511687517714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520216585; b=NWYCC45k56VcUxnKhD53d7TSRqBFPAAQG2zQ21IHtVZtf9t
    TvT8gAn5pkxp3j37demf/46zzfRSXwFX3J9xy26jCQtzxBJCnDcp34uWl8YfHm8T
    Ge9ujSUy8uoCAbuYfRmSW9h1g1VRh3kOCxbMm6Ytj9Z7/Z6kTUQEsUAXX1KGI0w5
    E6ZCDBQEcRWv4M4+YCfprSkWxawDGt+XnoDhDoH9L6BZk1KmAhQqENPXht4Ca/FO
    0MRNkuF876Z4CJ0MEv4iUAndNXj3/vDb7hkZwboyTefwcC/Yzn0hwtgX/lXCIsII
    6ablt3hKeIZwLiNv29wXJjRbOD1lYZ61eOILdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520216585; bh=on1E4y0nOFk93TFBifax20kHFYPDL/3FpSG4AX1k4/M=; b=f
    No/t9ECTUmeFLKy2/TZJfVm3yMXZfbfqNK92ie0ESpNpDRtSN9+v9Rsnw06dRjLv
    Zx99lbzcMI66DMHwkV0RvC53M2mNGVsJQjFEP5OVfKWDTjpTus4CNfzh9xgxSFNy
    2delFdlihMcQIC3vw1w7jouMnodMryql2AkivAnqw/7i4ASVWO+cxBDH9Of70h/d
    0S1TA24afLA7qzkU8Bx0nmpXSJ0kvsWrRpYIbNdth7wP/Nx2T6E5BiGJKtzkD02z
    TNfeQI+aLtdWCEKHZAQL104oIZZaZIcBD5Bvv2kI/yg4gFoiQUiiUozr6iVOl/Jo
    M/9dryK/vZXkH3k1eI7PQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeCECW5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 21:22:57 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:50226 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeCECW5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Mar 2018 21:22:57 -0500
Message-ID: <1520216572.2786.64.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 054/108] mtd: cfi: convert inline functions to macros
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 05 Mar 2018 02:22:52 +0000
In-Reply-To: <20180215151229.973271532@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
         <20180215151229.973271532@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-15 at 16:16 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> commit 9e343e87d2c4c707ef8fae2844864d4dde3a2d13 upstream.
[...]
> -static inline int map_word_andequal(struct map_info *map, map_word val1, map_word val2, map_word val3)
> -{
> -	int i;
> -
> -	for (i = 0; i < map_words(map); i++) {
> -		if ((val1.x[i] & val2.x[i]) != val3.x[i])
> -			return 0;
> -	}
> -
> -	return 1;
> -}
[...]
> +#define map_word_andequal(map, val1, val2, val3)			\
> +({									\
> +	int i, ret = 1;							\
> +	for (i = 0; i < map_words(map); i++) {				\
> +		if (((val1).x[i] & (val2).x[i]) != (val2).x[i]) {	\
[...]

The right-hand side of this comparison is now using val2 instead of
val3.  (This bug seems to be unfixed upstream.)

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
