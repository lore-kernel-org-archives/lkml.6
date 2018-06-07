Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TSsbLikyGVs2QwAAmS7hNA
	; Thu, 07 Jun 2018 13:26:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 99334608B8; Thu,  7 Jun 2018 13:26:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEYCTNhX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2D4E9606DD;
	Thu,  7 Jun 2018 13:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D4E9606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeFGN0M (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:26:12 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:38440 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbeFGN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:26:10 -0400
Received: by mail-yb0-f173.google.com with SMTP id q62-v6so3213664ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bk8WU2X0y2rSumMu/pagkGoUzDJh5NL9brrnz6lkl2g=;
        b=bEYCTNhX4X7vCOe/DqozwAWVUlOFjqED3Js8//7yYnOEpC/lSBi499sug56WbJTrWM
         OetmtY+0OSzYO3jguM3SXrZWsoKufx5utA6i1yJRZEovInjW0tPdxDTlWQdS96Nr7FEt
         gK49DbXFz++V/H6vz7OBdLWrk/OUjhMIgU6a+OujjknM9OQ0NeRnVYEk8b530mBX95+3
         bW+BSrtBWKg6hQx7zF9cJ4z3iDxyYsQz54tXpmSDSScAi8xCs/qQQMWZCmpHX+7x/FzJ
         sf/WjRVCroWKXdejME/0BfM5q63ouKTjuZVfBuicXG4m4JzbjxAAy42udTxPzyUjSerF
         hvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bk8WU2X0y2rSumMu/pagkGoUzDJh5NL9brrnz6lkl2g=;
        b=pPLS5G6xm5yKgFxClg/2raZbQO6tO2rAQanL+Q4ZfQhUzcz9uyouwmAh8ZhpgGK8RI
         z5DP4dyiS1KhansNPI6czhN5ffVZ64/Jzb8jCfJf1NCnnRSmlO6n8MdUtERHDvG1yRzz
         dvvyseSbOS0PQZ0He17YNzHVBDjrlQnoP0TNidhmfUgVekxUrcGJZ/ZubxEYnxw+A0GJ
         vXWgM6vtnXOeDUfxITnB7Mcp4VXczNMje3HkU6YFldtvtY2v4mWGrmecR66d8l7TpUES
         DC7DraZqnTCxJyXycN+k21JJQnTCTkPGCFisZu/mmqcCHTOWefzlQ4H6/dEl8g3aFFlB
         Uy6A==
X-Gm-Message-State: APt69E3bH6lYgH6Eq/QParOcYP3l4K5p9QZJb/J+3pN1VZ6W6iagR3ED
        FIN1aMiiprTuGVEMGr10v4fqisAviVVvN777F3gY
X-Google-Smtp-Source: ADUXVKJ0N2rvXlG0FWgSmj3e+tQIlz/NTqJozLUP34qgXUWTYPzs3UexTJ+xJOy6X878jJ7FsTdYcCPerCImuIvZXRc=
X-Received: by 2002:a25:49c4:: with SMTP id w187-v6mr1076080yba.73.1528377970011;
 Thu, 07 Jun 2018 06:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180206193546.52AFA21D4F@pdx-korg-gitolite-1.ci.codeaurora.org> <mvmlgbrj7tz.fsf@suse.de>
In-Reply-To: <mvmlgbrj7tz.fsf@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 7 Jun 2018 08:25:57 -0500
Message-ID: <CAErSpo6_BTHJgAhFJxQiVFenqns5rP98TRtSguL21h9HdZAxpA@mail.gmail.com>
Subject: Re: PCI: Move OF-related PCI functions into PCI core
To: schwab@suse.de
Cc: Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 3:53 AM Andreas Schwab <schwab@suse.de> wrote:
>
> OF_PCI is still referenced by drivers/pci/host/Kconfig.

Do you have a SHA1 for the file you're looking at?  In my current
"next" branch (488ad6d3678b), "OF_PCI" is not referenced anywhere in
drivers/pci/:

08:25:21 ~/linux (next)$ git show |cat
commit 488ad6d3678beee65bcd74e6a9764bd7cee9d3d3
Merge: 0ecda3a08746 82e1719c4cd6
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Jun 6 16:10:51 2018 -0500

    Merge branch 'pci/trivial'

      - clean up quirks.c organization and whitespace (Bjorn Helgaas)

    * pci/trivial:
      PCI: Clean up whitespace in quirks.c
      PCI: Reorder quirks infrastructure code

08:25:27 ~/linux (next)$ git grep OF_PCI drivers/pci |cat
08:25:30 ~/linux (next)$
