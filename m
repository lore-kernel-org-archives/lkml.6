Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeB0UDK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbeB0UDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:03:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A1820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Tue, 27 Feb 2018 12:03:08 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Julien Grall <julien.grall@arm.com>
cc: Juergen Gross <jgross@suse.com>,
        Andrii Anisov <andrii_anisov@epam.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        Stefano Stabellini <sstabellini@kernel.org>, jbeulich@suse.com
Subject: Re: [Xen-devel] [PATCH] xen: use hvc console for dom0
In-Reply-To: <b57092b4-e740-e1f8-3885-a817bb7d4e70@arm.com>
Message-ID: <alpine.DEB.2.10.1802271159070.4239@sstabellini-ThinkPad-X260>
References: <20180226110822.13787-1-jgross@suse.com> <0d8bdda5-faef-41da-344a-644b5c3d6006@epam.com> <58e94cc9-9b09-d6b7-3122-fb4c83e97926@suse.com> <b57092b4-e740-e1f8-3885-a817bb7d4e70@arm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1944649226-1519761789=:4239"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1944649226-1519761789=:4239
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Feb 2018, Julien Grall wrote:
> Hi,
> 
> On 26/02/18 12:32, Juergen Gross wrote:
> > On 26/02/18 13:06, Andrii Anisov wrote:
> > > Hello Juergen,
> > > 
> > > 
> > > On 26.02.18 13:08, Juergen Gross wrote:
> > > > Today the hvc console is added as a preferred console for pv domUs
> > > > only. As this requires a boot parameter for getting dom0 messages per
> > > > default add it for dom0, too.
> > > > 
> > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > > ---
> > > >    arch/x86/xen/enlighten_pv.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> > > Is this something x86 specific? Could it be a generic approach?
> > 
> > In case ARM wants something similar I guess the test for
> > xen_initial_domain() should be dropped in xen_early_init().
> I am pretty sure we discussed to remove !xen_initial_domain() for Arm in the
> past. But I don't remember why the patch was not sent to remove it.
> 
> Anyway, I guess this should be fine to have hvc as a preferred console for the
> initial domain as well.

Usually, Dom0 has access to several physical UARTs and/or VGA, making
this patch less obviously desirable. I think that for Dom0 the best
behavior would be to add "hvc0" as first console rather than last
console, so that if the user specified something else, this call won't
interfere with it.
--8323329-1944649226-1519761789=:4239--
