Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E716C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B3B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxc7OS4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfAQS41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:56:27 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:35637 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfAQS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:56:26 -0500
Received: by mail-qt1-f182.google.com with SMTP id v11so12557617qtc.2;
        Thu, 17 Jan 2019 10:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=eXGdA58LB03KIzz8jtLlW+Qk3NDztSphKtPaDkeJ26E=;
        b=nxc7OS4mys8K22fTsAFhZBa3OWeYnm3WUFf0eQmiNF0M3psVYZwTAAnnXHp0Rw07iW
         rI+pVAW983gUnmrSLATI9JfMyUOQDQKE1tMHkQ4P+EoQ/tmUXhBBRelxdwMOEDPHO/S8
         XOY7+FddzVr7jnMo20TRX5Anty8NPyeBBI/3O2HpCb2JSCT22hgdsV3xWJcdz7GahBvt
         97de6gerMBXA5iTQLOX2OqqL9Z6nLg5sbn5HCRBm4AU8C+dPvDtWs8oGHDVPQnPEWBOe
         fvCpLHxI+tnCO+seJ9tDXOZKWId4x8wcxXmu2a774un9VN8sJM1PK4QD1RNN/g98Q03l
         kCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=eXGdA58LB03KIzz8jtLlW+Qk3NDztSphKtPaDkeJ26E=;
        b=ZDN1YYZu0syoswsp/Olob5xDCaZsr9d9A0JgG3hBL6FMyfAIAmlvZlmeSZCh5+xerK
         jvRDSuMrE3jk88RCmjtCWc74JC2Rq/chC0TN+H4nMoBLk0+i1TZ/hsFcAtP1hg5pwxbU
         I1iMT8/MSVFtcOz5xEhu13yJu8fVHWJ9V6tMuqgd+Eh9jRNuQ/IK6T2n9G39p20J5JQn
         ykJHd9aODpDmUF2l1k7EagP9NMJ6t2eTCeSK7h80CSlfHYqKAIn9yFVnCRhrQoR6Ux75
         S6cN59vreC9DfMZ7E6os3w5kM8RR3NSHLNGW5wyHCU3yksN15tNDlIoIW5sWVKjoa7qh
         x0iQ==
X-Gm-Message-State: AJcUukfGHIw79BymR8MwmB652OqCUJF2Apag4DlRccoEYgrQaYAhrrKc
        0iPw+tCjdMVdcTHe3yJE1sZ0l6mKZC0=
X-Google-Smtp-Source: ALg8bN79JLIIGK+E1i95kW7BNCnc8helOLVBXcjC2rIy3aajAzAGZpiL0Xgq0+ASk5ibe/lx0j3x5g==
X-Received: by 2002:ac8:246:: with SMTP id o6mr5270755qtg.0.1547751385405;
        Thu, 17 Jan 2019 10:56:25 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id c48sm58138001qtd.9.2019.01.17.10.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:56:24 -0800 (PST)
Date:   Thu, 17 Jan 2019 13:56:23 -0500
Message-ID: <20190117135623.GD7380@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add suspend/resume
 callbacks
In-Reply-To: <b804e77a-5eb5-6d18-cb79-f8176e370775@gmail.com>
References: <20190116153419.3208-1-miquel.raynal@bootlin.com>
 <20190116155651.GC29244@lunn.ch>
 <e9ac5203-87ba-c14f-8140-5b100808a8a4@gmail.com>
 <20190116222329.GP29244@lunn.ch> <20190117104641.GD13242@t480s.localdomain>
 <20190117165052.6d1f1a58@xps13>
 <b804e77a-5eb5-6d18-cb79-f8176e370775@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 10:00:46 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>> A possible approach could be to call the port_disable, port_enable
> >>>> callbacks from dsa_slave_suspend() and dsa_slave_resume(), I might have
> >>>> some patches doing that already somewhere.  
> >>>
> >>> I expect it is also on Viviens TODO list, since this really could be
> >>> in the core.  
> >>
> >> Indeed that is!
> > 
> > So, shall I wait for Vivien's patches (adding port_disable/enable()
> > in dsa_slave_suspend/resume()) and keep the driver as-is or do you want
> > me to manually call port_disable/enable() from the mv88e6xxx driver?
> 
> Up to you guys, the only thing that I an tell you is that my platform
> loses its register contents during suspend/resume, therefore you must
> make sure the driver re-applies the entire switch configuration,
> identical to how it was prior to suspend. If you need me to test
> something, please holler.


Let's wait then.


Thanks,

	Vivien
