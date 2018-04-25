Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653214-2-7900688162957738332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653205; b=uFJxConyeAcO0VD/8bHVNy6j6dq1VoU3RNtKRLKiRZOvGm/Qs9
    oceyjcnrfYs1ElUc47X1S1uLzC2bBxN8IWPu6f050b+TMFmLEolguqLabRMLhP7u
    iQ7WoA5AV2jELiQHl8S0Q3YSkX0dJVIFcAmsgTGVPZBPJemuTcOslM4Gk7A5H+9f
    LQXCq5znQ8J+/CjAw9+9sKYTG2itmtCa+XHAADKM/UTifHhXSsSN0+dwIMtCFpQc
    bPyNKeXvb14hKZ0DmEwWlySaHBunAyO5tWjewQJbZZ3LqHBjiJ1iN8b+FyuJOOop
    IOXVIHlL6EbU3L33dOyIzz1/8GO279t+bjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653205; bh=uQfCiy4+rpZXeMbuazbeh/dmAHzwDh
    OkqUvDDqW6a/M=; b=tMSjr8JokUDw/7odeEDEE8oVt592Z5LtwPOURgcuMgFQAQ
    SgR/+sJ5G7vAyzqmmluXf4vPElabmpBrHEKokDgo61meywa4OtppxR9JCfE6SP9K
    2uZPjMDDioUHIeVXwds0RFStn8ZSHkZY5Y1iMAcyumuh0N3CuDdwS3rtmY/JoI2p
    4dZNh83VMLz48/rh0pRzM2aI4/YiydTJWQV8WEBmASdSskoUuSHgbRk696PXgLoA
    EsGWZZGE35K3D9B78wT4v4Ep9ycHdSBFcWXecfF9kH/ITuqkUat5I76cdm1xtosV
    j8JbynWRJ8eUG9R+Y11zf2QShsUM56bnxAJ+Q1ew==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGGIZ/WqJshuD02G8V9sbIyNEwjzzLjopTrDTvgG14Sb85b81xUOf8T/f/q8wct1aBz1gU4Rj7x0xTl+quDkt3nvotEMh7TYuzGMYZxjWQ1QucDvudig
    FgD/EADjJTOUCiESNtukRvmwwMhR/9+QeYhGiP9RX6ZczqjEo6sPcWFEjRagqGnTX9fy8RikblZnMvopc9zFvPbFUnql6Gf/PeLaKRj/yATdNzxt2Rmckcl6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=iXd9lturcMgjcm6p4moA:9 a=QEXdDO2ut3YA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeDYKpI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:45:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbeDYKpH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:45:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 150/183] bcache: return attach error when no cache set exist
Date: Wed, 25 Apr 2018 12:36:10 +0200
Message-Id: <20180425103248.568921100@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui@zte.com.cn>


[ Upstream commit 7f4fc93d4713394ee8f1cd44c238e046e11b4f15 ]

I attach a back-end device to a cache set, and the cache set is not
registered yet, this back-end device did not attach successfully, and no
error returned:
[root]# echo 87859280-fec6-4bcc-20df7ca8f86b > /sys/block/sde/bcache/attach
[root]#

In sysfs_attach(), the return value "v" is initialized to "size" in
the beginning, and if no cache set exist in bch_cache_sets, the "v" value
would not change any more, and return to sysfs, sysfs regard it as success
since the "size" is a positive number.

This patch fixes this issue by assigning "v" with "-ENOENT" in the
initialization.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/sysfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -193,7 +193,7 @@ STORE(__cached_dev)
 {
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
 					     disk.kobj);
-	ssize_t v = size;
+	ssize_t v;
 	struct cache_set *c;
 	struct kobj_uevent_env *env;
 
@@ -270,6 +270,7 @@ STORE(__cached_dev)
 		if (bch_parse_uuid(buf, set_uuid) < 16)
 			return -EINVAL;
 
+		v = -ENOENT;
 		list_for_each_entry(c, &bch_cache_sets, list) {
 			v = bch_cached_dev_attach(dc, c, set_uuid);
 			if (!v)
@@ -277,7 +278,7 @@ STORE(__cached_dev)
 		}
 
 		pr_err("Can't attach %s: cache set not found", buf);
-		size = v;
+		return v;
 	}
 
 	if (attr == &sysfs_detach && dc->disk.c)
