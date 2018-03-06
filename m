Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753472AbeCFLN5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:13:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:57230 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbeCFLNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:13:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="32775097"
Message-ID: <1520334831.7549.5.camel@linux.intel.com>
Subject: Re: [Regression] TPM char device not created if TPM 1.2 is
 disabled, but visible
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Sahil Rihan <srihan@fb.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Tue, 06 Mar 2018 13:13:51 +0200
In-Reply-To: <7A0881B1-6581-4D0B-A4A9-B014F995B338@fb.com>
References: <875E6A7D-483D-4A8F-9382-6B3970598866@fb.com>
         <20180305121445.GA3138@linux.intel.com>
         <7A0881B1-6581-4D0B-A4A9-B014F995B338@fb.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 19:28 +0000, Sahil Rihan wrote:
> Agree on keeping the warning. 
> 
> I'm guessing you want to return -ENODEV from tpm_bios_log_setup. Doing it from
> tpm_read_log_acpi will just fall through to calling tpm_read_log_of, which I
> think will end up returning -EIO again.
> 
> In terms of semantics I'm not sure if -ENODEV is the right return code if the
> BIOS event log is absent. I guess you can claim it's some sort of "device". I
> don’t have a strong opinion here.
> 
> Sahil

You are absolutely right. Printing warning and returning zero would be
the right measure to take.

One more cosmetic detail. Should the log level be info or warn? I mean
as far as I'm concerned everything is in a legit state.

/Jarkko
