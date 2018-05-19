Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeESPTC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:19:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeESPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:19:01 -0400
Date: Sat, 19 May 2018 17:18:35 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 09/39] x86/intel_rdt: Enable setting of exclusive
 mode
In-Reply-To: <975917b4b8e0ac91fa2b315d9ea1016c93d80870.1524649902.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1805191717430.1599@nanos.tec.linutronix.de>
References: <cover.1524649902.git.reinette.chatre@intel.com> <975917b4b8e0ac91fa2b315d9ea1016c93d80870.1524649902.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Reinette Chatre wrote:
> +/**
> + * rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
> + * @r: Resource to which domain instance @d belongs.
> + * @d: The domain instance for which @closid is being tested.
> + * @cbm: Capacity bitmask being tested.
> + * @closid: Intended closid for @cbm.
> + * @exclusive: Only check if overlaps with exclusive resource groups
> + *
> + * Checks if provided @cbm intended to be used for @closid on domain
> + * @d overlaps with any other closids or other hardware usage associated
> + * with this domain. If @exclusive is true then only overlaps with
> + * resource groups in exclusive mode will be considered. If @exclusive
> + * is false then overlaps with any resource group or hardware entities
> + * will be considered.
> + *
> + * Return: 0 if CBM does not overlap, 1 if it does.
> + */
> +static int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,

I think this should be bool not int.

> +/**
> + * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
> + *
> + * An exclusive resource group implies that there should be no sharing of
> + * its allocated resources. At the time this group is considered to be
> + * exclusive this test can determine if its current schemata supports this
> + * setting by testing for overlap with all other resource groups.
> + *
> + * Return: 1 if resource group can be exclusive, 0 if there is overlap
> + * with allocations of other resource groups and thus this resource group
> + * cannot be exclusive.
> + */
> +static int rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)

Ditto.

Thanks,

	tglx
