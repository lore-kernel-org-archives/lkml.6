Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeCZOz2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:55:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:29316 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752309AbeCZOzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:55:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="211393188"
Message-ID: <1522076116.16723.13.camel@linux.intel.com>
Subject: Re: [PATCH v3] x86: i8237: Register based on FADT legacy boot flag
From: Alan Cox <alan@linux.intel.com>
To: hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Anshuman Gupta <anshuman.gupta@intel.com>, glx@linutronix.de,
        x86@kernel.org, mingo@redhat.com, rjw@rjwysocki.net,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Date: Mon, 26 Mar 2018 15:55:16 +0100
In-Reply-To: <8A68406D-B05E-4953-89D1-D2AB49904644@zytor.com>
References: <alpine.DEB.2.21.1803191152450.2010@nanos.tec.linutronix.de>
         <1521714118-31282-1-git-send-email-anshuman.gupta@intel.com>
         <alpine.DEB.2.21.1803251348190.1481@nanos.tec.linutronix.de>
         <20180326054833.GA25173@raj-desk2.iind.intel.com>
         <alpine.DEB.2.21.1803261110430.1585@nanos.tec.linutronix.de>
         <8A68406D-B05E-4953-89D1-D2AB49904644@zytor.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can we probe safely for this device?

99% of the time yes the inb gives us a straight answer. However (and
we've hit this with port 0x81 for real) there are concerns that some
systems will trap those addresses into SMM and do weirdness that makes
the 0xFF check fail.

Alan
