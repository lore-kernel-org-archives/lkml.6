Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2593ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CC0205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CC0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeGTPIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:08:54 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:38046 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbeGTPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:08:54 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fgWGS-0001nv-OM; Fri, 20 Jul 2018 15:20:12 +0100
Message-ID: <1532096412.21552.35.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 022/105] libata: zpodd: small read overflow in
 eject_tray()
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>, Tejun Heo <tj@kernel.org>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 20 Jul 2018 15:20:12 +0100
In-Reply-To: <20180701153150.998817882@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
         <20180701153150.998817882@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-01 at 18:01 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> commit 18c9a99bce2a57dfd7e881658703b5d7469cc7b9 upstream.
> 
> We read from the cdb[] buffer in ata_exec_internal_sg().  It has to be
> ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.

zpodd_get_mech_type() appears to have the same problem.

Ben.

> Fixes: 213342053db5 ("libata: handle power transition of ODD")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[...]

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
