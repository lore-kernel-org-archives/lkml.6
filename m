Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeCMU3p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:29:45 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41483 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCMU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:29:41 -0400
X-Google-Smtp-Source: AG47ELsJz612FW1a7UNfs9lML0stulxzdQ0rpU+onnjIipyVnSW9iDot7RqnuklKOkDRuxcDuibRnA==
Date: Tue, 13 Mar 2018 13:29:38 -0700
From: Tejun Heo <tj@kernel.org>
To: Taras Kondratiuk <takondra@cisco.com>
Cc: Lin Ming <minggr@gmail.com>, xe-linux-external@cisco.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: add refcounting to ata_host
Message-ID: <20180313202938.GI2943022@devbig577.frc2.facebook.com>
References: <20171113201037.GL983427@devbig577.frc2.facebook.com>
 <1520584481-9643-1-git-send-email-takondra@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520584481-9643-1-git-send-email-takondra@cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 08:34:41AM +0000, Taras Kondratiuk wrote:
> After commit 9a6d6a2ddabb ("ata: make ata port as parent device of scsi
> host") manual driver unbind/remove causes use-after-free.
> 
> Unbind unconditionally invokes devres_release_all() which calls
> ata_host_release() and frees ata_host/ata_port memory while it is still
> being referenced as a parent of SCSI host. When SCSI host is finally
> released scsi_host_dev_release() calls put_device(parent) and accesses
> freed ata_port memory.
> 
> Add reference counting to make sure that ata_host lives long enough.
> 
> Bug report: https://lkml.org/lkml/2017/11/1/945
> Fixes: 9a6d6a2ddabb ("ata: make ata port as parent device of scsi host")
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lin Ming <minggr@gmail.com>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>

Applied to libata/for-4.17.

Thanks.

-- 
tejun
