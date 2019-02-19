Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32341C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA89E21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QvwpZODS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfBSO7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:59:30 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43837 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfBSO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:59:30 -0500
Received: by mail-pf1-f174.google.com with SMTP id q17so10349023pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bbQyydwGTTirw3UzuZQPM7i19iX5dNbackQGV5c/VjU=;
        b=QvwpZODSOJ2StdYW8IfVo9SDX33D5VsDBx9qA5dRZydxW/loh8hW1FWcucykiNKNG1
         hX+1Y3+rE/N90tPoyq12ks0nhJaQOUl7Knw7vCV4QAm4H6hKzkMLbk66sotvbMgoc/Bj
         m0gGX+Q4cFmGVfIaMakXqUcfg1Pu88UUAPPGSELkrC7m9B5/OYoSaOMGb1TqDBrDjEkO
         23tHpTQ4Mu5lxElyJpPwXJUQv4HgyVEowqVWzNYfAv6f30uQrACorOuiFI36hmtAq6el
         ZkIMMPxgT8FgrNJGQ9GYv0P5YSmSam38aYe36tPmXi4rzjzuIPVE0Ey5d4VAUH5rNAcM
         Qdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bbQyydwGTTirw3UzuZQPM7i19iX5dNbackQGV5c/VjU=;
        b=SD2dMvioRLSfIxdw0uwjfz+qQe9ZIxMNQ0hh8CQwlMg17TGhglJY49yXyb5J4K/p3f
         Q1alhA0GAUKe6k9FyiQMOGTSyyQ1RMFz2NM/A2nU7lpGN6OFkzUYIF4dWuCNC3Ib81LI
         wNw6gD228zCa5z8FoZzxfxy178QivcsjElqamuizEGnwoxwM7VAVulZW7IKtsODS6rZr
         yi1T4pfwfLA2wAb1weJviIq0hLEs9VyoAPVhPaq2fgbqNrDzqBC9PXMOUuZch/45/syr
         C8p0242RQWI9JKJXYOgh4wPqdq8kaSNTwWGvHazwkqyTJm7o2dQddIcNog9THEZsk1ad
         H2zw==
X-Gm-Message-State: AHQUAuZUuEngqm++JwqcbEISa8m9O0Fm+VA1tkiTpvd9D++6xysoeZmO
        HNOxBkyUumyDw6ab+hITF7lvn/7Xit9gkA==
X-Google-Smtp-Source: AHgI3IZhBLBIl7gr45g4/ywjr+kx/11oegon7QkE1zbhG8r+ngTxBEesExphcdFsaEuh4bQjyvi9Sw==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr24010990pgi.275.1550588369155;
        Tue, 19 Feb 2019 06:59:29 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id p6sm23767707pfp.15.2019.02.19.06.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 06:59:28 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id DCC843002B2; Tue, 19 Feb 2019 17:59:24 +0300 (+03)
Date:   Tue, 19 Feb 2019 17:59:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [LSF/MM ATTEND] MM track: Memory encryption, THP
Message-ID: <20190219145924.olggllneomorpenu@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to attend upcoming summit.

I was not very active in generic memory managment field last year. I hope
it will change this year.

I'm still interested in moving THP forward and I see there is a number of
THP-related topics proposed for the summit. I would like to participate in
the discussion (and hopefully contribute something).

The other topic I would like to discuss is memory encryption and userspace
APIs for it. See Dave's topic proposal[1].

[1] https://lore.kernel.org/linux-mm/788d7050-f6bb-b984-69d9-504056e6c5a6@intel.com

-- 
 Kirill A. Shutemov
