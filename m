Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeDGPkU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 11:40:20 -0400
Received: from la.guarana.org ([173.254.219.205]:58264 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeDGPkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 11:40:19 -0400
Date: Sat, 7 Apr 2018 11:40:18 -0400
From: Kevin Easton <kevin@guarana.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] af_key: Fix for sadb_key memcpy read overrun
Message-ID: <cover.1523115061.git.kevin@guarana.org>
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

Both these patches apply cleanly to ipsec-next.  Based on Steffen's
feedback I have re-ordered them so that the fix only is in patch 1, which
I would suggest is also a stable tree candidate, whereas patch 2 is a
cleanup only.

Kevin Easton (2):
  af_key: Always verify length of provided sadb_key
  af_key: Use DIV_ROUND_UP() instead of open-coded equivalent

 net/key/af_key.c | 58 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 16 deletions(-)

-- 
2.8.1
