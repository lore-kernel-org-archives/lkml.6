Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00072080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3u5lxBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBEGnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:43:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44314 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfBEGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:43:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so479659wrn.11;
        Mon, 04 Feb 2019 22:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvt1gBX8WugZ91yn9owVv40hdROA38XCFOkwQHyD13c=;
        b=Z3u5lxBRCB1CtcyB28C8/R6pCs/O5Gxt4YvM/+tVHicyFBoiMTKmW0Zt3NIYb6I+4h
         iRj4dtN6Fz2vYla8jJ3L37lM3VeHrPC8O43YR27SS88THJJG7t7yjz5cQ+3QPpYTzNXb
         P7jGDOFmnlhr9rF10N0aNqELj2VApJ5PePI3zvfVQz86GeMHJYtAr8rCJVZ01SV1EiNZ
         5SOtJKosQn6ra86M6xhr4t318ymQP04Gu1pgYibTAaE9jUPMcD+nJUaNoFKnZYbsjnnk
         YgpU+IE/v6a0kabUfL0UwV6B+IYPB/urZwFhtse9kscHWl0DqYKTP4M1sqWKCqk1pVzx
         V1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvt1gBX8WugZ91yn9owVv40hdROA38XCFOkwQHyD13c=;
        b=hwkKrmjNf1z4fWkvseS8PnEPWqyHmIJ+b3LmC2zp88xlc2UEDZOUOuMpGTrgWsEmGl
         hbDv7hTc3N60aa0GW6l4eWfoRuGoPt+38PGaVSOKyrYTMqEtilgrskPsuhRTe+aWvFt6
         ERzbbJHSFi1/b2ALXCtTuIDuLi0eICWjjG3Hv0Tn5JSFlPit5VLGJlKRv4R22fidwSgn
         QOU91KATGAx3KgIObXt1imKJGrvr08CAlSf+Yii6uKlCrTmV314fCzwdzHR1+2cOPwVx
         229seRFW5R0906rpSPODSrzGEY1TSd3jz44SMAYobuilB7Q/mf31/AO1DeRjjIpVi27D
         9gng==
X-Gm-Message-State: AHQUAub0Ch409oSj8myTPltYa9YJZBezTmUwLJfyWRMT0v5+4C4gNEvB
        Z6GkKUIKBpzyhydfJW5Cj0l+L7k=
X-Google-Smtp-Source: AHgI3IZP9z8nEicnVGORS3TkzJFsGYkKRQmvAKQwTvuWZjW0uUixchVu8ulhFrcqiBe0MLUJ3nsDcw==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr2358679wrt.235.1549349017459;
        Mon, 04 Feb 2019 22:43:37 -0800 (PST)
Received: from avx2 ([46.53.243.91])
        by smtp.gmail.com with ESMTPSA id 129sm24049450wmd.18.2019.02.04.22.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:43:36 -0800 (PST)
Date:   Tue, 5 Feb 2019 09:43:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH -mm] elf: fixup compilation
Message-ID: <20190205064334.GA2152@avx2>
References: <20190205014806.rQcAx%akpm@linux-foundation.org>
 <08a894b1-66f6-19bf-67be-c9b7b1b01126@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08a894b1-66f6-19bf-67be-c9b7b1b01126@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	fold into elf-use-list_for_each_entry.patch

 fs/binfmt_elf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2110,8 +2110,8 @@ static int write_note_info(struct elf_note_info *info,
 
 	/* write out the thread status notes section */
 	list_for_each_entry(ets, &info->thread_list, list) {
-		for (i = 0; i < tmp->num_notes; i++)
-			if (!writenote(&tmp->notes[i], cprm))
+		for (i = 0; i < ets->num_notes; i++)
+			if (!writenote(&ets->notes[i], cprm))
 				return 0;
 	}
 
