Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 444DEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2622208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2rmxEet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2622208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934868AbeFLRA6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:00:58 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:42323 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFLRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:00:46 -0400
Received: by mail-wr0-f173.google.com with SMTP id w10-v6so24848698wrk.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9OGHl4eAjo7hwTXsWKY7BL8ruo0x05yIdpBYSSu0cVI=;
        b=g2rmxEetFXMBRyCURVict1XKU/nYWf9s5wilfCgQvbSvg72G+crlRpZnAj+U2dnIIM
         5M0PS1w5fuR++gSFza0gdW5a8nbZtZpqfPBe0qPWAAaaqtXZPIl+Ty7IDkm3iznD8tET
         DkDlMXrjx7wlijA5+xMLG2Y81vB+e/ycoB4b7cWSFCM8yokGJgfrTlg/cDUG04Kiw3qU
         yq9aFkSOj+hQkKEaMoNyTJnMtSFyZci2wRvmwdQ6IdyP71Z9GKBe3IlCLM20loDIia7r
         K4zetGYbWJJp0e3RtR2c3G6eqfSbjcQrNRF2DqJtJpBSws0cteG4sMx1ElVD7PRMGSxH
         XUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9OGHl4eAjo7hwTXsWKY7BL8ruo0x05yIdpBYSSu0cVI=;
        b=NQwNFTJmzrxmMHPStbwVmrUaS0B5y9OvYWPmLosKC4k7Qm5Yabvd/G/5lLa9nqQ0ng
         l4j/PMJC6UrYTh+YjUDCE45V0C0jd9oZ2huXf8rvSYmptOQbr3uh1obppFq5jWp77758
         Y7eE4UXTmKyU3iaVYch32wFPFEaoNFHlT/kkNHlkFRue3CwKvltW+ni1LJZjxlPfkGUS
         lWpZ+b6WSk6vWV4tPPu+L0S9tSyFCx7MyXU5rBdxMeXwtQkt2jO29y99ii7UbNmb+qJP
         pVPKEyW3vrEOudHBS1bvmZ2SfdnBl8N4g0pVy04IZkSi6nutFNAAuuhbUa45cOfrYIOv
         Yctg==
X-Gm-Message-State: APt69E0ZKF+t4N74pfQR1txPv+useB+OT+9NvLCmqPljYPZ6pGFIRXqg
        auMqRLwjNw9YeFqxol4dqVE=
X-Google-Smtp-Source: ADUXVKJXRSu4BJj76wqhJGt1hVGMOHt/vyZb4o1qQnvKPawAkfXamxKHFZX9Hr4eF9atb20f8np/Gg==
X-Received: by 2002:adf:ad8a:: with SMTP id w10-v6mr1024213wrc.83.1528822845200;
        Tue, 12 Jun 2018 10:00:45 -0700 (PDT)
Received: from localhost (8ta-151-219-142.telkomadsl.co.za. [41.151.219.142])
        by smtp.gmail.com with ESMTPSA id f17-v6sm13379486wmc.2.2018.06.12.10.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 10:00:44 -0700 (PDT)
Date:   Tue, 12 Jun 2018 20:59:30 +0200
From:   Chris Opperman <eklikeroomys@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Simo Koskinen <koskisoft@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180612185930.GA17592@kerdev>
References: <1528554204-4388-1-git-send-email-eklikeroomys@gmail.com>
 <20180609140527.GC28854@kroah.com>
 <20180610103001.GA7804@kerdev>
 <20180612085616.ukbpgtx7s4nxiekz@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612085616.ukbpgtx7s4nxiekz@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,
Thank you for the feedback, I'll update V4 of the patch accordingly
and resend. I'll soon get a hang of the workflow! :)
Best Regards,
Chris Opperman
