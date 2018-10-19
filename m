Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17318ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9F62148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9F62148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJTBjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:39:13 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:40100 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727338AbeJTBjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:39:12 -0400
Received: from mr2.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9JHWAAi019507
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:32:10 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9JHW5c1013198
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:32:10 -0400
Received: by mail-qt1-f198.google.com with SMTP id 4-v6so36483423qtt.22
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=lXbgz/gQPPzbY8TXj/WsWvtvGmHbTPTrxs/knma1r+s=;
        b=CoUw2zNy6cKbiR6l/gY8fmYMqecGVFanrWfD1/fj+77vaS3bDwGLd+qm7vNN8DRQuR
         qzoZOHZISZ+8IqQoXKs2TF7Zi4qddpK1GL5qVvTCC5ww98CvHPVQy5yAnPw0ZhMT7fPj
         XSl8AXkRCN1eD+mLeOXhLrp+trnvzLFzX4Dkcho5xv2UBmCEYZ3tNHsSQRGhKNJgJF7t
         OnHH/pf2ebfsurxAkpT3IimeJzOZEhYF6bBZUCC27mPryGPau7/ApWT1+WYv7E20WP2K
         QyHEy6S0yvrRnmgcagC66RFNF8xsnUxP/Td1rE1R22/I2ASJkYDw6P0beoqBRgOIwyXj
         Os/w==
X-Gm-Message-State: ABuFfojOJ3GwA1dl/bvHkL5ExLZzsE65u2MFCjYVQUAOB6o62Zm2PtH0
        jnlSgdiLUInglHSj72IitVXDxp+g6KQy+EvA2PjGiWTeVLEErYlkJmzQKCCyGO5zeAnaX/y4PV7
        5qDzxoj2NtmVg4HAPDLZDClTwDdvEgzd4Rno=
X-Received: by 2002:a0c:967b:: with SMTP id 56mr35271023qvy.62.1539970325077;
        Fri, 19 Oct 2018 10:32:05 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63jMuiZvgZ9MCTus6pooGo920BAICiYyrpf37xWxL+IDlvWExknslR9Z2awnIY+hWt73iyVfA==
X-Received: by 2002:a0c:967b:: with SMTP id 56mr35270984qvy.62.1539970324777;
        Fri, 19 Oct 2018 10:32:04 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id w39-v6sm17659595qtc.84.2018.10.19.10.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 10:32:03 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, dancol@google.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
In-Reply-To: <20181018065908.254389-1-joel@joelfernandes.org>
References: <20181018065908.254389-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539970322_3102P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Oct 2018 13:32:02 -0400
Message-ID: <42922.1539970322@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1539970322_3102P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 Oct 2018 23:59:07 -0700, "Joel Fernandes (Google)" said:
> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> which prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active. The following program shows the seal
> working in action:

What is supposed to happen if some other process has an already existing R/W
mmap of the region?  (For that matter, the test program doesn't seem to
actually test that the existing mmap region remains writable?)


--==_Exmh_1539970322_3102P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8oVEo0DS38y7CIcAQLWJQf8DQ1cQowO3bfaWQWZBNXxbcCeCMPYgp1w
3XFonoT+hSpd45gHazrRRXmfR3BJ0wb9wZHsE0CCCpmuXlNnH2WOmKB7/ly/5lb8
RQhT8ahp8/OzRpRnfDlLQEIbAY/5kT4XGRf1wjVBnonPYY8aXjSj44dyBIaPh8XZ
GJLYEL6++rWifApraHDHgBbMQCEn7HMXnvoHtIcV3/ihRj+bo7H74Cr8S7e6dPCP
sLtruVLu00SYYHkTI6l0rSAZiMiYJnVyuk3bju4jTMqX7KayRCmzS9X+65F5jb/M
qJhZ/DLjV/n3/DqK9u2z5tOsiN4scyW1ThQpK+tjXj0SC+9a0VoAoQ==
=fFpS
-----END PGP SIGNATURE-----

--==_Exmh_1539970322_3102P--
