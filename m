Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeCZLjK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:39:10 -0400
Received: from la.guarana.org ([173.254.219.205]:47364 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbeCZLjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:39:09 -0400
Date: Mon, 26 Mar 2018 07:39:06 -0400
From: Kevin Easton <kevin@guarana.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] af_key: Fix for sadb_key memcpy read overrun
Message-ID: <cover.1522063171.git.kevin@guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As found by syzbot, af_key does not properly validate the key length in
sadb_key messages from userspace.  This can result in copying from beyond
the end of the sadb_key part of the message, or indeed beyond the end of
the entire packet.

Kevin Easton (2):
  af_key: Use DIV_ROUND_UP() instead of open-coded equivalent
  af_key: Always verify length of provided sadb_key

 net/key/af_key.c | 58 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 16 deletions(-)

-- 
2.8.1
