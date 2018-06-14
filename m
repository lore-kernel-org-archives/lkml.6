Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2B06CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65CD2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6T/Padn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65CD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964882AbeFNQT4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:19:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51648 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755194AbeFNQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:19:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id r15-v6so11546623wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d3mwBd8p5KzZ0NQkxn93pWd+SLOjHimaE98WDaVEtzg=;
        b=L6T/PadnDtkMVDxPUwtbJCHgN/kLPohYCvp+Ut1cASpi+PrQvIUPEL6zSeeq4XvFUg
         zJ/MtKUX1/HewvcT4qBfwgl5kD6R/GNn8z4d+q+JRY6mXmURgrQW0dd2wLPKVSBW9NYh
         IlQKkxd525daBAk8q6F8oUtFwU00aOulIMeh/mDbLSIy0hMpKGStrwc9iIrJUpNHzXxv
         RZ60zneMA4UpwsPkc1vrwn597Er8wlpwfraNQcFh4BWcVk2gntCCQp7fk3xSe/NkP+zr
         5yK4qUv8UPJynY+zFEMup6LzotzU3Zm5h/TkgjAqFiHqca8Gzkwp3bTskdn6QaGsJOSx
         YFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d3mwBd8p5KzZ0NQkxn93pWd+SLOjHimaE98WDaVEtzg=;
        b=XzrRP6QMLCfLfEppNXVPhAPbTxvwy0wbcW8Uy6f4Q3j0A7VX/7TCsGaMf/LCwsiT96
         jPkJvnEGLYa7ZIoA/Vte+tR7UGRJH+hdN39gvXV30GUA+WAiYRZt9PMSy5KXWcq8fptl
         uwlFQ7k4Jr966PyJ5jwfqq3vq/g7gxLBMwkEgvGrcFzRJIz0NH33ho1ePWigAaqWgmo1
         H4pBEVWMIAZj/ZB32TdU8UtfGqllc2FIUZOhYL7q6UFRwbVMBxIIyp4fRZKqEEhaPx1W
         LJ+e/9QmW0gNo0kbuEpEWbU+x9qGiAQaoLqPbQ3ByIl6rniHFCpLj0vrSN2UJqt9QkmZ
         1+LQ==
X-Gm-Message-State: APt69E0zTy8cQRc8CinSOHftLiV37QOi0MeA5rxnxl/yUZ9nfnJXrOkq
        /J6rYgUUZCjGsLXp1tQQLqA=
X-Google-Smtp-Source: ADUXVKIISn7b2NUIxwPvipa+7IerLxE5C+bkeg2Bs136f9A9jCnaplUvpMV3aJE8/qma0uNUKVlFQQ==
X-Received: by 2002:a1c:99cf:: with SMTP id b198-v6mr2243454wme.15.1528993194330;
        Thu, 14 Jun 2018 09:19:54 -0700 (PDT)
Received: from localhost (8ta-151-219-142.telkomadsl.co.za. [41.151.219.142])
        by smtp.gmail.com with ESMTPSA id v13-v6sm5672094wrq.43.2018.06.14.09.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 09:19:53 -0700 (PDT)
Date:   Thu, 14 Jun 2018 18:18:07 +0200
From:   Chris Opperman <eklikeroomys@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180614161807.GB3846@kerdev>
References: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
 <20180613092955.vc5impf46prhcur7@mwanda>
 <20180613182643.GA14100@kerdev>
 <20180613190549.ugl43yee4f3thk4t@mwanda>
 <48e9826d-3f60-a79a-779a-2296a89afad0@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e9826d-3f60-a79a-779a-2296a89afad0@mev.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian/Dan,

In that case I'll stick to the cut-off line format in future. Thanks!

Kind Regards,
Chris Opperman
