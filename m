Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeFDE3C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:29:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:20732 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbeFDE3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:29:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,475,1520924400";
   d="scan'208";a="46513969"
Date: Mon, 4 Jun 2018 06:29:00 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>
Subject: Re: [PATCH] NFC: fix attrs checks in netlink interface
Message-ID: <20180604042900.GB31498@zurbaran.ger.intel.com>
References: <75ce3040b4086ffa2d2e088ad7f24f5e4a87be56.1523552145.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75ce3040b4086ffa2d2e088ad7f24f5e4a87be56.1523552145.git.andreyknvl@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Apr 12, 2018 at 06:56:56PM +0200, Andrey Konovalov wrote:
> nfc_genl_deactivate_target() relies on the NFC_ATTR_TARGET_INDEX
> attribute being present, but doesn't check whether it is actually
> provided by the user. Same goes for nfc_genl_fw_download() and
> NFC_ATTR_FIRMWARE_NAME.
> 
> This patch adds appropriate checks.
> 
> Found with syzkaller.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  net/nfc/netlink.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
Thanks, applied to nfc-next.

Cheers,
Samuel.
