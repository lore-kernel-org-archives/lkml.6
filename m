Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756ABECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D4B2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3rtK/BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D4B2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeIXPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:34:51 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39840 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeIXPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:34:51 -0400
Received: by mail-wr1-f53.google.com with SMTP id s14-v6so18921201wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=w5KMkapIP7M2Cxbz2FAG+rJCPlRY7OZmE71Aymb1fdA=;
        b=m3rtK/BP8FW5a94gwoOJet3tI0aAC8FPRXMbV3RiHdBsGYkQZWMfxZ6HCX6+J29sFG
         kCd/OvG6VYFfSg8rPitlNLXs81bYsgPUM7Z9eTJ2c478KU1pZbmX9sD6vDoeiQvfw6U+
         kJkD6xcwLcRvIBYGefVEG1j042+f7e2UV80ewHgVGNQ83sLKmI7zjqgNvmXBeEnsHgA+
         L14B6rwegUSYpF5BYlOgeFRyB1skwtRk2b5K8Hu8sMYU/gjiqIHRWSFFTJxvC/AQw6zn
         SAUsLfRzSZvAOqlzdp+DtTTOiDvwQzX5GMO+RBLzjqGn82Zv/Gj+9FPQMRQEMZN93pVR
         HFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=w5KMkapIP7M2Cxbz2FAG+rJCPlRY7OZmE71Aymb1fdA=;
        b=sgFamfYlUIOv8FqXRzFGumK7jyUBgwZUptcWx1KYdhsYNUsqIlR67zIQFUaH++jFF+
         Bs5U/yAiKMTC1jDq2RcU4KST1Xx+iYrXtONyiWdTOoG+7Vu8CSGYql1g/pMRndI7Vnik
         bIOS09hvIZPEu/Xb5pZvXIYtkL/kkEs50kDF7ASes73LydyOMYq9tKWy4CIC5b9WHMtP
         yaLXvRt0RXYd0ezJc+bBtAggU7DvRAuxCK1rfYwJKKeFcV0sJtDLvypvK2w5hyCGs7je
         tVpGvcpHUSLfWCPS0XZCbsg0LEzprZKIDcGx7385vGVM4OOSqatJaxXDRLigG2jiGK/S
         A9vA==
X-Gm-Message-State: ABuFfohWW+4cUsYM8rTo8HHWovqYWTmUa3vnP2z+x1xQUKecos1AUz4Q
        QkOqeTHd1SdhBzxopfVpL6W6uegIYTPORdN1BcTkD3L9G27ZDw==
X-Google-Smtp-Source: ACcGV632qqubemBJEdBQbCF3RT3ZBvx9LidyytxlCukzI41xPILlMEZN9pJXjCcPnUoHgEuhaH9JHJOO7bzZVvH6xlw=
X-Received: by 2002:adf:84c1:: with SMTP id 59-v6mr7422555wrg.97.1537781619722;
 Mon, 24 Sep 2018 02:33:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:94c2:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 02:33:39
 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 24 Sep 2018 11:33:39 +0200
Message-ID: <CA+icZUUdxjVe4p-9aui0cqj_EiHD3O2VZ=dW8HqWf-+9jqnWCA@mail.gmail.com>
Subject: Linux 4.19-rc5: Missing iommu fix
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

thanks and congrats for this release.

Me and several other people have an issue with "intel_iommu=on" (see
[1]) and a patch is pending in [2].
Unfortunately, it is not in linux-iommu Git.
Hope this will soon happen.

Just want to inform you and let people know if they have a similiar problem.

Thanks.

Regards,
- Sedat -


[1] https://www.spinics.net/lists/iommu/msg30105.html
[2] https://lore.kernel.org/patchwork/patch/983690/
