Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6615C32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DA221479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DA221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeKUIfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:35:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52143 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:35:02 -0500
Received: from 79.184.254.110.ipv4.supernova.orange.pl (79.184.254.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id f43fc8eb7f94c78e; Tue, 20 Nov 2018 23:03:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] device property: Add fwnode_get_name() helper
Date:   Tue, 20 Nov 2018 23:03:45 +0100
Message-ID: <4687553.lNXoFSueqb@aspire.rjw.lan>
In-Reply-To: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 8, 2018 5:51:52 PM CET Heikki Krogerus wrote:
> Hi,
> 
> This is the second version of my proposal for this helper. The
> first version can be checked here:
> https://lkml.org/lkml/2018/11/5/326
> 
> In order to support also ACPI properly, I decided to change the API.
> The function fwnode_name() is now fwnode_get_name(), and instead of
> returning pointer to the name, the function copies it to a buffer. I
> did that because acpica does not offer a way to get a pointer to the
> node name, and the name is clearly expected to be accessed only with
> the namespace lock held.
> 
> I think this is better approach in any case. It will also solve the
> problem of getting rid of the unit-address part from DT node names.
> 
> Let me know what you guys think.
> 
> --
> heikki
> 
> 
> Heikki Krogerus (4):
>   device property: Introduce fwnode_get_name()
>   ACPI: property: Add acpi_fwnode_name()
>   of/property: Add of_fwnode_name()
>   device property: Drop get_named_child_node callback
> 
>  drivers/acpi/property.c  | 43 ++++++++++++++++++++++------------------
>  drivers/base/property.c  | 34 ++++++++++++++++++++++++++++++-
>  drivers/of/property.c    | 26 ++++++++++--------------
>  include/linux/fwnode.h   |  6 +++---
>  include/linux/property.h |  2 ++
>  5 files changed, 73 insertions(+), 38 deletions(-)
> 
> 

I will be expecting at least one more iteration of this series to address the
Rob's comments.

Thanks,
Rafael


