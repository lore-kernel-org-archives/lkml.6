Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDQOHU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbeDQOHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:07:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A108D21727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Tue, 17 Apr 2018 09:07:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
Message-ID: <20180417140714.GF28657@bhelgaas-glaptop.roam.corp.google.com>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180413110820.662d4879@ThinkPad>
 <20180413092908.GB2119@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413092908.GB2119@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 05:29:08PM +0800, Baoquan He wrote:
> Hi Bjorn,
> 
> There are changes I have made to solve 5-level conflict with
> kexec/kdump and also interface unification task, they will involve x86
> 64 only changes on these functions, I don't think we need remove them if
> without any obvious impact or error reported.

Removing the weak attribute from the declaration in the header file
does not prevent you from defining a weak function later in the .c
file.

We should remove the weak attribute from the header file declaration
because it can lead to non-obvious errors, e.g., calling the wrong
version of the function.  There's no build-time or run-time indication
that this happens, so it's a real trap.

Bjorn
