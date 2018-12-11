Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F26C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C862054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544539014;
	bh=6JYjh+0yMAl1qSgfk1x6M2ZZ4rNUmedP28jYCrv49TY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=migEV0bXEPBbFbojoeYfUj7sORX4sFYr0cNZ2EMnLh7Vr2LCRLrDKZzGaza+XFM0J
	 /mA3mvemFL7pJthMP7h8TuzeAerjbdsx9CCv1Jg4tSBNlzaP4q6Hn+Rja7aKPdAYp3
	 5Z37xlFUNe/S6sPQYvg0qvrywrlnJ7HDvVM7tGzs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C862054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeLKOgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:36:52 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38877 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:36:51 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so12713168ede.5;
        Tue, 11 Dec 2018 06:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JYjh+0yMAl1qSgfk1x6M2ZZ4rNUmedP28jYCrv49TY=;
        b=Mz5JDSQUiVpGC/Yclzagi5bn1qA1PQO529U0qZa/7XQa5QQwNYu1NXbnEqKcwjk/P6
         wpWdlBl7RUVmXjxb9yjqgAdHVT/eiJoXXAWVAaLjeKUTBrLmADYws1XoDm1Gzm5+fn+D
         D1cd7ha8jGxIK3BzEGy9xx6t1kOgbGDAPQcrRWfuBmuKxF0rZjvqcXgcAlmeh5w/4upJ
         XoqcXQepf2iQF+GzFW7pD31J+46lFMZQGaM5mnr+ynK4HyKhbU26JR7Rf0Bty825P8+D
         LRnDwT2OtU7MayhqObUYtdC+lcgoDOQ16xYuiFTqYcu4neFiA8WHON6yx2TSdDG9ukp/
         78WA==
X-Gm-Message-State: AA+aEWa8SzItgON/H/491TZFjhCv6AoWSu8QKKVax55gOJWLpCTg5QwM
        Sr4UkZBpX28SSB0LdHHMr9raux7R
X-Google-Smtp-Source: AFSGD/X+7qKEXHj6z9FFzkR9Hizd6ozwcuRjk5QvfAAQKQU95feCYZVDLocsAXP1NBA+uGiCvL8S7w==
X-Received: by 2002:a17:906:f6cb:: with SMTP id jo11-v6mr12637748ejb.80.1544539009053;
        Tue, 11 Dec 2018 06:36:49 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z40sm4017084edz.86.2018.12.11.06.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:36:48 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/3] THP eligibility reporting via proc
Date:   Tue, 11 Dec 2018 15:36:38 +0100
Message-Id: <20181211143641.3503-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've posted this as an RFC [1] and there didn't seem to be any pushback
so I am posting it for inclusion. If there are any concerns, please
speak up.

Original cover:
This series of three patches aims at making THP eligibility reporting
much more robust and long term sustainable. The trigger for the change
is a regression report [2] and the long follow up discussion. In short
the specific application didn't have good API to query whether a particular
mapping can be backed by THP so it has used VMA flags to workaround that.
These flags represent a deep internal state of VMAs and as such they should
be used by userspace with a great deal of caution.

A similar has happened for [3] when users complained that VM_MIXEDMAP is
no longer set on DAX mappings. Again a lack of a proper API led to an
abuse.

The first patch in the series tries to emphasise that that the semantic
of flags might change and any application consuming those should be really
careful.

The remaining two patches provide a more suitable interface to address [2]
and provide a consistent API to query the THP status both for each VMA
and process wide as well.

[1] http://lkml.kernel.org/r/20181120103515.25280-1-mhocko@kernel.org
[2] http://lkml.kernel.org/r/http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
[3] http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz


