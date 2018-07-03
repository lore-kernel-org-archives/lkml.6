Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F470C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B704242A9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMEYiSsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B704242A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeGCGxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:53:42 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43755 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754465AbeGCGxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:53:38 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so685165qtp.10;
        Mon, 02 Jul 2018 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QM+mOh4gh/gmwe4SPjIfXXWDDSPkZ+69y0JM6NT1Irk=;
        b=DMEYiSsjy2f/L4Xx0QhVhezzmSo4L4TEnpkt5vxTqKkVgkjKh0kbXW/k3DcGoWsz1P
         bDmSfdjb8RKPgbypgF262wDAmIADuOfTVoq3TTiYqya7oDcwK3byZlhP7IKE+ENL2aI1
         i2IzvUaUXc96Px3Y1xUrI+aGYYmYr9FKoF98eyltxusMnto47jWXqvTd/WW+rmYc0CwF
         6KTULlY0qsaP+88qOF+o6CPK+lK9yquzghIBcGwvPoRuOlMk5sKm1049vOrWruj2d8b/
         2TcoObxNDKdNp4nlTBAhw2SsCqolNa8HjJOw8Dn4CD4ULRZ03iJSxtOzt2/nX/NEMT7T
         2lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QM+mOh4gh/gmwe4SPjIfXXWDDSPkZ+69y0JM6NT1Irk=;
        b=hXLYM7+gxcTzulGFXZCzR3fCwreb5V89vqJRDOwaFXo3UAS7wnK7fqupnQ89UWQGmE
         G6pdpEG0e2sRX6X0bNjbBy2F1MhgFINitzcTws89Pz1VyO3yLYUOMUDCeiK+bu5yDRgW
         HydE+hoO4IVvm58Nj7VneqikjS8P0ibjB3wyZfKi4H2sw50fRBZpKuY4My/WthkJfEfz
         r38gJSo8p8hlFTWo8qTgeH8y5L07W7e5ebFI9gS+z+7khc/o3ItfFQ4lquJmlsEn5j40
         eNEjNg0vulWyyOLr7yOk90pwqx8m4M5nMsVAxiy+Q6dIN3a8VpG3odpthJ/TXoLcLrVG
         J4Iw==
X-Gm-Message-State: APt69E227QM0ce0ocki6SPdrk/0dM0NQfSVJyCtVq4DdtaiMkuCeeKHY
        cXj/1dq6af66Q+OVuARisVC4R9fL2NA7d6s3Ybe1nQ==
X-Google-Smtp-Source: AAOMgpcVudzre7yWvbZdAzTlm2MwIEUHuwUBfBABcQ0gg15Vb7MyU5+cdGpby4DHszGw8rOTJ+Na+1PxJI0kiTzAcaQ=
X-Received: by 2002:aed:35f8:: with SMTP id d53-v6mr10451038qte.239.1530600817564;
 Mon, 02 Jul 2018 23:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180628054205.17737-1-luaraneda@gmail.com> <20180628054205.17737-3-luaraneda@gmail.com>
 <eda7ca2a-e2de-8939-0784-89b619f6035e@xilinx.com>
In-Reply-To: <eda7ca2a-e2de-8939-0784-89b619f6035e@xilinx.com>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Tue, 3 Jul 2018 02:53:23 -0400
Message-ID: <CAHbBuxr0C0qLHE71SgCQR9=ZWfKXy26DC_XfqNAO3-_aEJ0E4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] dt-bindings: xilinx: Add missing zynq boards
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Jun 28, 2018 at 2:44 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > -- Xilinx internal board cc108
> > +- Xilinx CC108 board
>
> No reason to remove internal word from here.

Ok.

Thanks,

Luis Araneda.
