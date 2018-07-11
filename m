Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7198C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6484220875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9wb+hLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6484220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbeGKObw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:31:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37718 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388654AbeGKObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:31:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so19349264edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXIKnPEr3/WuaSwXtcplJabavCybxQR/A1ylP/fLt60=;
        b=j9wb+hLbtCAoDAMoTIJ/F2j1N+gRFKuSVknU0RFVRZRYB75XRwMKZ6xshUqL/Z08Gr
         WXDFpwCvAZ/ntDibP+TrnXUqgLpZcns3td9MeVzLNMSFKhiF3W7emSMNPEFWDYhtgqf8
         grEiHMtyxcvA9OPiQ34lNK/wgNFDzJ0AP/tuv8VGENrl6zJnD9QZTbVd1emkiGqNI24r
         0qb1HgcMXgtW8GEHtUtK9W2eP9E7Zn1zvJjCrvvOpXXE40DqZ0owolTFg+SUia2MH45i
         cEsQspPgtTeZ0nA++KwObW5AHEtsUQJEvQGBxT54/onERGp9e7eur82amOGiFe3l0kTX
         6tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXIKnPEr3/WuaSwXtcplJabavCybxQR/A1ylP/fLt60=;
        b=loRF0Uf2aLGr0IJr82+Xnvqff0D0Z8HGK9+cLHgUD2mo77hx0KjbNqBKN7pwz8iDO1
         b8+yuQdba9sR0FF5CFvHx1rgm2uV84uyvnk4KzlbIt9sCY5sAMfmS6wCge7/HOHvyfx1
         aKPNLLEY61pFdyIpff0lf5vB8wMnyTxf6SxkywlWEPDobgoQJkJ1Qxajl4IHelxN7dhl
         pssL4ehtka+xDZY7w18KG4lY83FCAfnJWXNzlQSzhDqvVjC3OQ+CYCkwnz4OVakK+w8i
         fFx1Xm8G0WX531YigLrl4/UkPlQwTCO+RCSEfaHq4J/4LeS+M627g1svEFJw4MHFb6Vi
         KOIQ==
X-Gm-Message-State: APt69E2fHKCTblhaZIZKXO1dRbMiP9f1cgbijBn1bJgb547obLWNKTWb
        TgEZ2zpfWGnSzjUu3Qn6ScQ=
X-Google-Smtp-Source: AAOMgpdBDS9PMNARFtDXDHLTpQuMMZtHNrYOaRefxFixRtcmZJNOi+D2nfHumayDr3WEmxoMj4jfLQ==
X-Received: by 2002:a50:8561:: with SMTP id 88-v6mr32235420edr.181.1531319235004;
        Wed, 11 Jul 2018 07:27:15 -0700 (PDT)
Received: from xux707-tw ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id r20-v6sm2925735edd.94.2018.07.11.07.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 07:27:14 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:27:11 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, kstewart@linuxfoundation.org,
        keescook@chromium.org, aastha.gupta4104@gmail.com,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 3/8] staging:rtl8192u: Correct spacing before and
 after parenthesis - Style
Message-ID: <20180711142710.GA12935@xux707-tw>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
 <20180710150523.17384-4-johnfwhitmore@gmail.com>
 <20180711111349.GA28836@kroah.com>
 <20180711140935.GC26416@xux707-tw>
 <20180711142250.GA3907@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711142250.GA3907@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:22:50PM +0200, Greg KH wrote:
> On Wed, Jul 11, 2018 at 03:09:37PM +0100, John Whitmore wrote:
> > On Wed, Jul 11, 2018 at 01:13:49PM +0200, Greg KH wrote:
> > > On Tue, Jul 10, 2018 at 04:05:18PM +0100, John Whitmore wrote:
> > > > Corrected coding style issues aroung opening and closed parenthesis. Spaces, or blank line, removed from after '(' or before ')'
> > > 
> > > Wrap your changelog text at 72 columns like your editor asked you to :(
> > > 
> > > I'll fix it up this time...
> > 
> > Oops sorry and thanks. I thought the magic number was 75 which I got from:
> > 
> > https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html
> 
> 75 works as well :)
> 

Well if I went over 75, which I knew about I'm very sorry I messed up. I'll
keep an eye out in future. Might be using the wrong editor but let's not go
there.
