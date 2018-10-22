Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72E5C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F9120663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVWypXnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F9120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeJWDv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:51:27 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37793 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeJWDv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:51:27 -0400
Received: by mail-yw1-f65.google.com with SMTP id v77-v6so1795258ywc.4;
        Mon, 22 Oct 2018 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t7A79sz8CAMxg/XP8CmKeP8660UskTz4yd18T6q5SzA=;
        b=CVWypXnSTlsgLsEWsjjqvtIRh0F5meaM6dI8ELxDb+4ZwBKlB9Gur0m2wd6Vcc9EEx
         +xsmvHrSTXP4lI8INo0vZmE+kKcVQPa6RESCAC76XOdZazJZHp0kHGFiKgkqIn1hfl/a
         J3+D2woEQ16ABBXEe0yDELsckJomvxt+oJk6w5oYjskm75VngjSs+4uQCG9Hk8AXl2X1
         mi9zGeaS+kGMgujB6Yd1EpYwjh7bqFw/3r58zGgHOFepP7gW8iXzRv1UQquy1ONUb6EG
         dfkStmDmToGRqDAT2p6gvjwyqDhuvQtJ/orQ06MKV+h/QE7t3o5mjpwXwr3WsaHLNht+
         +erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=t7A79sz8CAMxg/XP8CmKeP8660UskTz4yd18T6q5SzA=;
        b=B56C8bJnuJbU+rWwXxgO+9G+FnqRXvhiyORBbrhtdondZcsYFq4VVid8gkQFIK/fMX
         dAE6KcwSc2IXx0iQgQgd7OqQYsEnVdj/xLwD45FJPnhwiqDQpAnH3tVeFKKxAnWPGQqm
         SgrqF0eL3mBT13SiOVjPDbJtGt2EVfNDcuoZ0onbxsVz29B42oe5av7FNn8ki27CmVHE
         XywHmZOCMDWzbLjKkAILAfKhKhXp6zYjKOd7LXYZhuP6KASgIU+rhhFzH8JFq26NfK/R
         IMIVKgoouyk84YtOzpIGuztctte79pQTxN7gYo3+7ShUMcGOE1tiNNkLtldPtFaq0c7d
         xXpg==
X-Gm-Message-State: ABuFfog3s4niKkaIBcHEkVP3zR3u02J6YVMhm05oKlBAKc36M4MaAhBU
        1ap1jppUoPRPfVx+F77szZVCxxRl
X-Google-Smtp-Source: ACcGV62yZLTkBp5Q3OOgQ7HUFHPJvo9Ljgq4NI1ApMGY3jW1g1QgNPj8sx++lP0AfGTEepF0n3PjTg==
X-Received: by 2002:a81:a8c6:: with SMTP id f189-v6mr33941411ywh.350.1540236697449;
        Mon, 22 Oct 2018 12:31:37 -0700 (PDT)
Received: from dhcp-10-175-29-12.vpn.oracle.com (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id b19-v6sm9503368ywh.29.2018.10.22.12.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 12:31:36 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:31:33 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
Subject: [GIT PULL] (xen) stable/for-jens-4.20
Message-ID: <20181022193132.GB20677@dhcp-10-175-29-12.vpn.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Jens,

Please git pull the following branch:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.20

which has exactly one tiny patch fixing an NULL pointer issue (also has stable tree CCed).

Thank you!

drivers/block/xen-blkfront.c | 3 +++
 1 file changed, 3 insertions(+)

Vasilis Liaskovitis (2):
      xen/blkfront: avoid NULL blkfront_info dereference on device removal


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbziWUAAoJEFKlDoTx2wm/LeEP/jzfxixLC5x9JxlYAg9G3VwF
h0pzABE7VDNPfeRTIV152g63xdtiBjWMTK74bO/hkqxvmtsCEeKzIm8MQPj+QF7P
jWadDoVLFds7yKxSJq6vm5wPqd+C6hZsmQUFVjNAnLX1nfxy8GjjsavMyJxHVMCe
oB2WF9Frk9K6yn4gUxmjOyWWD0N2eNNFuPNb+OLjx0/l/lG7p0ADCZ0fwEZgywJ4
6yFgHy8DBsWYqfe1RMT3t5wULFxNeaV3hiI+2YLcYtcmCoHJHwSQd4DjPhO1WsNx
LyhK37BIhX3P4aqLwVxMlSEuBR+VPxRH6mslrJoxOAhZJCloYEEjivNUadKlO1kR
BjM/1fVlDsHF5IbtreBghCO3mlZ+QJI7Zzr3ijh0jy5Il61VKp2BdbjxCgmbZPLq
IeAO4h+Q/kBLrBrU2HPda0NACjah9Eq/5ajY7TcG/CoHY+V9TkNsBLL5qG4ioq5Q
OokX1ZFbOvFvOVwLZmaJTvC9IsPnUeQrWbgr7JAPqiq7+A/CSz9uT6cXJ1mDrfZB
I9B5M3lhugaqPcL+LkGpXFPcl+yie2LAHWUGxDTBzYMmpER+Wy8DQiw1qzcDFhzh
L/XnPK05Kr1Dt4IROoWunwzMb53B/QJ1u3yttoQ1sTpFLi+La46O9ej7HL2l7/Hn
oaxGGpPP4yhb8t9WJ6CQ
=HN4e
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
