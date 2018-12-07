Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFFDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55E120989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544187464;
	bh=5CabJzGnyItyXZse9qXf9Mpks7WgWw3K0MOpR4TI+Q4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EFejnKLb5dnedCZ6f2d4i89YLw/ZAODRWizeG5/+QZzawJ5wtaWykK0I5uVaolFuO
	 yeAO8Z7MZ0q65/g7xo6U1RTmFED88W9dD3Po7Od17rgVyAJ8C3fWJUKq0hGOLxFNBs
	 hTaf5gdZxvQVZ9P0HwZRvxyWTEnMgrdzdmlqBrEk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55E120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeLGM5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:57:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34431 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeLGM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:57:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so3489202ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=miIw08rJI6Xmm1VJ/Zh/jd86+M92uyqKn0VdXeaEZbo=;
        b=FiiK5bHhc/FWamAvGZKjLDlnA2P+a+xtYRddqadCVXVYsSvg1H2cPmOURQ2eyNLIt6
         X4xLoG/HoVg/uWysmQOWCDH1bR3uudbCfig4aD6T4nba5ulGEcBC2O4bp/oB4WJYODTK
         faQdWi5lBS7rAENgJRr/sQJOzqk8DYiaXxrxwIF9bdfje16UBbrF7ffmkUDch/OBbYy+
         qEntQqtQzKl6XSClj6dgFud+HO2bQGCb3Z0oFbxrDPgVbU0jFPS6nfhgQklrnBljhpYx
         30pJZaDMl1sJhkfgE40xhEMAXsmyygWo/DkoYCDlnkpxjtclQT0rTIMfq/meYCw9doNF
         gnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=miIw08rJI6Xmm1VJ/Zh/jd86+M92uyqKn0VdXeaEZbo=;
        b=r9Nt4j0My134Ol+/ff6JAEcIhQ9nYZnrnK1Od/ItiYoD2fESV9FT6QdchlySjfbc1G
         e6dKib47j/9FaMnvUoy0TjanGdjulFEuYRHebe8A/m0es4+1pta2CydsvCB5Qwhb21ff
         zyB+WQFgOjjRECpgkin+lt0GYjrqmVvExqZ9+apdG57HNS8jZWYPObDM5ZZgTL9gPsGK
         ilzva02OocgihlTV+RVcjabrx1+Aq6TnqgU8eoTYD/8gH4q9L1WQ2V/eVE8Oo8Kwc6xH
         pj9SaaJ1fa3hW6PK3R8vlFHYn3d6F4Jinu/O4aO+FeOGYIMcBWRngucRXpHsH0A+vILa
         64Rw==
X-Gm-Message-State: AA+aEWb6fqDvtuqzTAv8aGpZRIa5LVJxbXaK2OmMdxi2KD1AIx3hx01K
        1RzX8gA/sOwXiiPK7QnGhSEJ4LIW
X-Google-Smtp-Source: AFSGD/Uz69YxsuYNCjSsg26joN2pbJ0AoblinsK0gj64NeIl3ptQ4vIof7dplRP4aEPYTEQXjk8+2g==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr1345537ljs.118.1544187458064;
        Fri, 07 Dec 2018 04:57:38 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d23sm595675lfc.11.2018.12.07.04.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:57:37 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gVFhR-0002bW-MT; Fri, 07 Dec 2018 13:57:45 +0100
Date:   Fri, 7 Dec 2018 13:57:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS fixes for 4.20-rc6
Message-ID: <20181207125745.GA9989@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-4.20-rc6

for you to fetch changes up to 63cea1f735284b2244e3f031625c65373520eff9:

  MAINTAINERS: exclude gnss from SIRFPRIMA2 regex matching (2018-12-06 17:22:58 +0100)

----------------------------------------------------------------
GNSS fixes for 4.20-rc6

Here's a fix for a broken activation retry loop in the sirf driver.

Included are also two MAINTAINERS updates.

All have been in linux-next with no reported issues.

Signed-off-by: Johan Hovold <johan@kernel.org>

----------------------------------------------------------------
Johan Hovold (3):
      gnss: sirf: fix activation retry handling
      MAINTAINERS: add gnss scm tree
      MAINTAINERS: exclude gnss from SIRFPRIMA2 regex matching

 MAINTAINERS         | 2 ++
 drivers/gnss/sirf.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)
