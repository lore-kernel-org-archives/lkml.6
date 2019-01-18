Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386D0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1352020823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfARMet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:34:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfARMet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:34:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DE8289AE6;
        Fri, 18 Jan 2019 12:34:47 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E80D3608C1;
        Fri, 18 Jan 2019 12:34:41 +0000 (UTC)
Date:   Fri, 18 Jan 2019 20:34:37 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
Message-ID: <20190118123437.GA30929@dhcp-128-65.nay.redhat.com>
References: <20190118091733.29940-1-kasong@redhat.com>
 <1547812432.3982.55.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547812432.3982.55.camel@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 18 Jan 2019 12:34:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/19 at 06:53am, Mimi Zohar wrote:
> On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> > This patch series adds a .platform_trusted_keys in system_keyring as the
> > reference to .platform keyring in integrity subsystem, when platform
> > keyring is being initialized it will be updated. So other component could
> > use this keyring as well.
> 
> Kairui, when people review patches, the comments could be specific,
> but are normally generic.  My review included a couple of generic
> suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
> term "preboot" keys, and remove any references to "other components".
> 
> After all the wording suggestions I've made, you are still saying, "So
> other components could use this keyring as well".  Really?!  How the
> platform keyring will be used in the future, is up to you and others
> to convince Linus.  At least for now, please limit its usage to
> verifying the PE signed kernel image.  If this patch set needs to be
> reposted, please remove all references to "other components".
> 
> Dave/David, are you ok with Kairui's usage of "#ifdef's"?  Dave, you
> Acked the original post.  Can I include it?  Can we get some
> additional Ack's on these patches?

It is better to update patch to use IS_ENABLED in patch 1/2 as well.
Other than that, for kexec part I'm fine with an ack.
 
Thanks
Dave
