Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3DEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB17A218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acOAxKnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBFXKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:10:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38171 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:10:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3844855pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/12Ba3S5JYyK8lxK8I94q9cvVCUPhSiYrzpfwkz5Vlk=;
        b=acOAxKnNf6f8AxBTtLexY3jzRyJ8QQPrrjfy4I+JujX5XMp//gq65PoAif52sxRgvm
         p5fCzdWazC8YkzDB59PYDyGsSTU2ymcNdSDNkr3vd8+ntgf8tbndzFqt/Bu3NJ3GaQj6
         SHDnQuJbzWX5K42ientRGrRX/E1PbFDkyhSYClZb6aQGbxmWJFR1kO8cQh3O3DsU/XfL
         Vu8UhX0YIe6cBJUAvPF1fSkG6r4GT+cWR9apIUe4kLg5ncS17bxsRQtHwfOblvqeCXfR
         z9Lcsn2hGqb8iZcIf9jdiXcx+FHWTlAtxV9WKDeRZH3P3g06VNRnuuLxSedWmr97B6ee
         yvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/12Ba3S5JYyK8lxK8I94q9cvVCUPhSiYrzpfwkz5Vlk=;
        b=JCOVOAye1MQU31Af8skVoufxWZqkFH+ahyrO/pOmvPpgWB60rOaVIfj8fNYY1l1E7l
         VbP5CkSxwVGD4ckJoghrvTeTpSO9dQG6Rb8px32uY31zjU5g5SzcI73uKEHnSVJe7mGN
         Znn1j7h146N8DHqqgD9lKVdGrJdxUKhx+cekxOrU46yvvGPFDDnpTKkUxz855KX0jS4H
         Sa5RJYZypqWBs4YjXWZVmwC+N+5fYZAsvizeqeFJF+0SFXU3vuWcCI0DcaRJ8Ee3WfTr
         t9eq4RwDoRGDEusWB3pyslxdMuOxJm0QR8Rs2vEvBfjk9BsJ1+27cDK2nKG+uGocCnnb
         +PpA==
X-Gm-Message-State: AHQUAua6Fy9GXkgAjNvFoepQaQqmJXuHmzrUgB0Xw/ccpHylnirqLAvj
        IRYm48ZuxPtzqYmDu+NCvp8=
X-Google-Smtp-Source: AHgI3IYy3Y7YWDCZiCS/rTgQHTrAYDZtvdVm1L1J+d/HjNrWCytcdogzQeOMltnX6uyreVN4ftD7zQ==
X-Received: by 2002:a62:1f97:: with SMTP id l23mr12909842pfj.13.1549494620259;
        Wed, 06 Feb 2019 15:10:20 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 4sm10254880pfq.10.2019.02.06.15.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 15:10:19 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Nick Piggin <npiggin@suse.de>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] mm: page_cache_add_speculative(): refactor away duplicate code
Date:   Wed,  6 Feb 2019 15:10:15 -0800
Message-Id: <20190206231016.22734-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

I ran across this while working on the get_user_pages() + [R]DMA problem,
but we might as well remove the small bit of code duplication, independent
of gup/dma (which is going to take "a little bit" longer to get submitted,
ha).

John Hubbard (1):
  mm: page_cache_add_speculative(): refactor out some code duplication

 include/linux/pagemap.h | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

-- 
2.20.1

