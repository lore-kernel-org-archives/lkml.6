Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF19C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C170217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="H9HeO40d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C170217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeHEBOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:14:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32863 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeHEBOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:14:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so3439039edr.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 16:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version;
        bh=rcWirVGSTTfZg31RIqwxhCSdbDk0LZLE9UwaajKfQ8g=;
        b=H9HeO40dqvv2mT8VJQx79Fji9eFn2yKJOk33DEKlXYVJLTAgmCv0MOmcG27aw4zTwy
         53NH9zie0CDtgBnO2mID3tQM15QoNAIauGVnGOjVtc02VWhjz5vTawH9rP6EGrLFhUqp
         knNL9t5CdDTpPA//tigcvVhLI+gH+A7gs5zHVxCdbIBE9R9u+4lvqfHxmS0fXvBV+0Le
         La1fCo4V5Q9P//X66Fax6YcrDa72yltsVo4ew5OrsFEij3ujydOg089bYQemzuznY7qp
         lt1mN4EFABBL5YmjBM29J3pOa6JoWqK6oqHA4gKpu+nb4cIssrnNidX0+axD6mg2wsRO
         hbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version;
        bh=rcWirVGSTTfZg31RIqwxhCSdbDk0LZLE9UwaajKfQ8g=;
        b=RsfFyheC3ZjBcgBHw7AnBCnS8qjx8s8bzn/F5Awguy3apAN6jhgMWlDx3C9h90PXxM
         AreE0ZmSpusA59zz5SeaiKhP38H7Pg9shnn+HZz4WFipaqt6rcJgN6vj37Bv96f4091j
         Wp8I6rpwHXhnQPKAZ7II/XU8SwlQYP2bvp3hMUMbG0+aLD8+h41XovyC24nGbZHTG8vC
         OxuyX2lcHYbBXcPAF3ud5p7xmntegnv6KTDjXMCncDl9eB++Mz5ecN2x2FBmKZAT9+N2
         L68Z/z0dc0wneKCXuILgcLh8HGpTJYz3WRlxBzImn0D1ESaEpTPzCJNzvKqIQZv1qd9k
         NSpA==
X-Gm-Message-State: AOUpUlEgfThP46LBZbcdOeENWK/7OFpN9z3wbHKgZdWXMOxmmqTXoMo3
        cR1Os8fNTP0wktv1Aq4uq+Aysw==
X-Google-Smtp-Source: AAOMgpdH03Rvz3r8Xww57TPnG4OG/X+7K0JF52dgTK7/CjbRA2DPR8XixoJ2OkSYr5/ysRXDie6BSQ==
X-Received: by 2002:a50:cf81:: with SMTP id h1-v6mr12792211edk.35.1533424324518;
        Sat, 04 Aug 2018 16:12:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id i3-v6sm3405832edt.42.2018.08.04.16.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 16:12:03 -0700 (PDT)
Message-ID: <1533424322.2679.144.camel@arista.com>
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
From:   Dmitry Safonov <dima@arista.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org
Date:   Sun, 05 Aug 2018 00:12:02 +0100
In-Reply-To: <20180804224956.GA5384@flashbox>
References: <20180804082702.434482435@linuxfoundation.org>
         <20180804082706.427556290@linuxfoundation.org>
         <20180804180734.GA25546@flashbox> <1533422007.2679.141.camel@arista.com>
         <20180804224956.GA5384@flashbox>
Content-Type: multipart/mixed; boundary="=-YbZ751X/tMPKSmR3Rgov"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YbZ751X/tMPKSmR3Rgov
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2018-08-04 at 15:49 -0700, Nathan Chancellor wrote:
> dmesg output attached, please let me know if you need anything else.

Could you try with this diff instead?
It looks like, I'm too bad with shifts and shifted for 64 bytes.

-- 
Thanks,
             Dmitry
--=-YbZ751X/tMPKSmR3Rgov
Content-Disposition: attachment; filename="netlink_groups.diff"
Content-Type: text/x-patch; name="netlink_groups.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9uZXRsaW5rL2FmX25ldGxpbmsuYyBiL25ldC9uZXRsaW5rL2FmX25l
dGxpbmsuYwppbmRleCA3ZDg2MGEyMmU1ZmIuLmI3OGJiN2RjMDZmZSAxMDA2NDQKLS0tIGEvbmV0
L25ldGxpbmsvYWZfbmV0bGluay5jCisrKyBiL25ldC9uZXRsaW5rL2FmX25ldGxpbmsuYwpAQCAt
MTAxMSw3ICsxMDExLDcgQEAgc3RhdGljIGludCBuZXRsaW5rX2JpbmQoc3RydWN0IHNvY2tldCAq
c29jaywgc3RydWN0IHNvY2thZGRyICphZGRyLAogCiAJaWYgKG5say0+bmdyb3VwcyA9PSAwKQog
CQlncm91cHMgPSAwOwotCWVsc2UKKwllbHNlIGlmIChubGstPm5ncm91cHMgPCA2NCkKIAkJZ3Jv
dXBzICY9ICgxVUxMIDw8IG5say0+bmdyb3VwcykgLSAxOwogCiAJYm91bmQgPSBubGstPmJvdW5k
Owo=


--=-YbZ751X/tMPKSmR3Rgov--

