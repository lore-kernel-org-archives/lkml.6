Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F394C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C52E2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6fJZzYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfANPMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:12:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36060 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:12:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so23293370wrp.3;
        Mon, 14 Jan 2019 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JMyyfx9hIDQ62IuglPjl3Zl0cSv2t+hhmijMRrdaVQM=;
        b=u6fJZzYA+j0U2X2AZHyo1odj191AVZuV6B/Cl4U+ZrqMwWOlBfURPBsAWT2l8VVT65
         XT2xS+8HgbaiTpLncueUCSrgX6CKhbaBbttoMF/+xax4drTQRvmePeP9Ldh5Kixa28lb
         4N6zWSwIm9iHIFdbxeBCnBqX2vnZo7hDcORWxDttaNz4husbQegK0v4jSisj/XZ4g4Lh
         QRxmbfw/KG0kNorJXWrWvLKwVBYbU4QA/c80+gmOhaIUafeQ1jpuVCvLy4qJHhNAwqU7
         kNvNbfph2W365rgqqYdnv63Knj95hvUF/2YlQlbmHKRjHRcsBZZ9oBnnw33/24Z7XP86
         FxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JMyyfx9hIDQ62IuglPjl3Zl0cSv2t+hhmijMRrdaVQM=;
        b=tf4Wgx8ykbAmkUdkkh/fe8TquRbj6vj/Kmzptb2Y8eQtr/TWeCeyjav4/2icry5zIB
         q0HrpVX50Ri6ughbfyvFL0VX4CzAATnlxWYyifN79nAHd+5rQIJ3O+5SQ9KuO7kfHhla
         We6tS9vLBL/nUinKNKy7hI5CMIK0NzkmnfiFxV0+T6eg7W0nLTHhEZOlKM53dtHQwWQl
         g86n7CPvd0tNtDZkRQ8TUKYd3K8CshS5W9QlNrNx18zGNNukoiLnfWn8+kFK8bVZ6kRf
         xhdC5+diA7+E4lew7HPBfx3iouvpEsVtWW9H+L0rtSnumgxtbJ7NcAGTRFeQOTkYFv/h
         g6dw==
X-Gm-Message-State: AJcUukdzP/YIpJpaXzIuQPlcj15vpR6C5Pu428IEAUzKsnK+Llgw/8BK
        fLSg1ByxgNGbZN7QTAqeZyVPqlV3
X-Google-Smtp-Source: ALg8bN51hN6bgyDKibPoO7B7lxjH2LPKBF3G/q68U63m3tk3a0p/NOj1seLu6Cm9/NROwF68lx+Lqw==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr23687172wrh.317.1547478764340;
        Mon, 14 Jan 2019 07:12:44 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h16sm152141897wrb.62.2019.01.14.07.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 07:12:43 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:12:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Kevin Weidemann <kwe-lnx@postn.eu>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190114151242.vrspcgld3n645qez@pali>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190114103011.GD13316@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2019 11:30:11 Jan Kara wrote:
> On Mon 14-01-19 01:33:30, Kevin Weidemann wrote:
> > I have an issue with UDF. I used to be able to create a UDF fs in a way
> > that is very similar to this:
> >=20
> > `# mkudffs --label=3D.... -m dvd -b 512 /dev/mapper/cryptdev1`

Hi Kevin! You should use -m dvd only in case your crtypdev1 device is
DVD. -m dvd prepares UDF filesystem layout and alignments for DVD media.

So you should not use -m dvd for hard disks.

Also DVDs have block size of 2048 bytes and UDF mandates that medium
block size matches UDF block size. Linux versions >=3D 4.11 do not have
problems with it, but other operating systems enforce that rule.

So you should not use -b 512 for DVD medias.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
