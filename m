Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968930AbeCSUrc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:47:32 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35628 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968664AbeCSSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:09:53 -0400
X-Google-Smtp-Source: AG47ELv0MvuL5OxTxRCJpchNtMwTU47tMbcQzT1BKSJB9ZxD4vLhOwk5h7SNN1LG5CyKT7RM2xqgTQ==
Date: Mon, 19 Mar 2018 19:09:50 +0100
From: Paolo Pisati <p.pisati@gmail.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Alan Tull <atull@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Message-ID: <20180319180950.GA15921@harukaze>
References: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
 <1521215669-23874-3-git-send-email-p.pisati@gmail.com>
 <20180316162654.bcr7d46om2tnhm7l@us-sjc-wireless-10-16-34-48.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316162654.bcr7d46om2tnhm7l@us-sjc-wireless-10-16-34-48.amer.corp.natinst.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 09:26:54AM -0700, Moritz Fischer wrote:
> >
> > +static enum fpga_mgr_states machxo2_spi_state(struct fpga_manager *mgr)
> > +{
> > +	return FPGA_MGR_STATE_UNKNOWN;
> > +}
> 
> To understand this correctly: Further up you have a way to determine the
> state you're in, but then you only use that for debug printout, while
> here where you should provide the status you say FPGA_MGR_STATE_UNKNOWN?
> 
> Am I missing something here?

This is more of a generic function ('What's the state of the FPGA now?') while
dump_status_reg() is invoked after a specific SPI command is sent to the FPGA to
keep track of the status of the chip and check that it adhere to the state
machine.

I'll send a v7.
-- 
bye,
p.
