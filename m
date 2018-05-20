Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeETWhf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 18:37:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46750 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeETWhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 18:37:31 -0400
Date: Sun, 20 May 2018 18:37:30 -0400 (EDT)
Message-Id: <20180520.183730.1550159916165131561.davem@davemloft.net>
To: wang6495@umn.edu
Cc: kjlu@umn.edu, mac@melware.de, isdn@linux-pingi.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isdn: eicon: fix a missing-check bug
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526679228-1596-1-git-send-email-wang6495@umn.edu>
References: <1526679228-1596-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4KMbejI016404

From: Wenwen Wang <wang6495@umn.edu>
Date: Fri, 18 May 2018 16:33:47 -0500

> In divasmain.c, the function divas_write() firstly invokes the function
> diva_xdi_open_adapter() to open the adapter that matches with the adapter
> number provided by the user, and then invokes the function diva_xdi_write()
> to perform the write operation using the matched adapter. The two functions
> diva_xdi_open_adapter() and diva_xdi_write() are located in diva.c.

This doesn't even compile:

In file included from drivers/isdn/hardware/eicon/divasmain.c:30:
drivers/isdn/hardware/eicon/diva.h:23:18: error: unknown type name ¡diva_xdi_um_cfg_cmd_t¢
      int length, diva_xdi_um_cfg_cmd_t *msg,
                  ^~~~~~~~~~~~~~~~~~~~~
drivers/isdn/hardware/eicon/diva.h:27:20: error: unknown type name ¡diva_xdi_um_cfg_cmd_t¢
        int length, diva_xdi_um_cfg_cmd_t *msg,
                    ^~~~~~~~~~~~~~~~~~~~~
