Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2927865-1522393951-2-16737128822210923408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES dasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393950; b=KRZvQgo7IeTZOLAaP70KA8Cv1ob+Hk1JEVILEis/skIYHkNhzx
    TvF1N7IgdAiPG2sojtdes9aozSDFsfjgim5TKsemcgXeGFSvCyZK/qEc/8IpFYrK
    CjUbkltofrax9wDPLkaJ9tCqR5czPhQE0xvf1I1kYPOgbDf6H/vgniHAuOk3hRwK
    QuAB/ug+Vfg44BJ1YP6QChiPvEXdZPnIDMHJ8FaXN/vmuX3jqV6dxRSo1TlhFKnl
    ra49MO1/Ah1m86hD2UZRLunUDUgHNjfmBCh1Q9srHb0c333JR28CQC7kqcwHLs6S
    YFhRNLksfEvAz74Kd/omHPLrdcuExYghIFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393950; bh=Py6fl
    Oe4Ab8RUlXM1AFoYbG6SiuVBIO3gUTJ/T1g3wE=; b=sNFWXS6uUOQmlPzUfVT0K
    GBxKNkapmDrTPK3woY4X5rFTjr3y5f5p+F6wz8QDO7AYhgHYVG43fPa1wqilVkOv
    kUaTX8u6jj4te9uK8pBGkRrH8/JpDAM0NU0s9KGd8BAenpx06yW0s3XTA57QsauU
    fF0zuSalx8k2gxYr6Da2c7s2hexn43NJNWr+4Fj7IehyuDgp+UfLmC/n8ZAmU+CT
    9y2Xi+kOh3P7Lc6MxcE3Se4sAj4yEIAWRT+kWg6+x9ASTmzSmpUFvhQdnS4T/Wnp
    rdR7b8lPC/9jG57itUun6x5BGv4hDWWtC6P2fwAREM78nYS/La+Cy0HgnPAx81F/
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCNOShXJafIeeapkOp6TDUw7jdPhKtAtla/iWa5e0/OgFBnhsOv6VKXf/STZ4JIfsLcZRxucsX/9hp+5RZkgZkhQ1ypG6gvjoQCM6eyp9C2xNQ9cy4w2
    Coj0knAAZwHnkp4P2BLlgazqPyxgod0h7Kf8B/7m4AGOTN7PyNPWKxyE816JkrFbi/NZfBpeXpb+nQELO+wSsLCYS/JoMnFy7rH9uXlOp1Xnub1RYGi2R6b8
    lOy7rtPqAEF2/rKIVsI9lw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=O9dBBwVSkpohp3HG-88A:9 a=jnkqDrycITDSPqYg:21 a=KTsjBreWlKLpSknJ:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 74/76] staging: ks7010: Remove unnecessary casts in 'struct
 ks_wlan_handler_def'.
Date: Fri, 30 Mar 2018 00:08:40 -0700
Message-Id: <20180330070842.25224-77-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:AuixmYSPnQkR1YBx5fMyqrqvQSKS1hJVtFzMvs56U73vmhhKaQn
 QtMXQFSjdWTKOyqMQa544tuoY2mBSQtDncFJfWutE6Erx2LBB3PN/HGsFqnBbW/DwOezvsA
 ffpyql11lrYrYpFIXbnALrkosKvorM6Vv3iTD8n9YQD1OGnefqGxvjTM4Lz5PJdWoEpJ5fR
 VOGgH5PRMXL+uasa4yGIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EPR02lMVpug=:nNu3D8X6f0mGX/dLxiZ8MI
 wNl5S38dOFMIJZ43wzHYXUT+kT7UyKqrk+GQyh/Nny8jpouebe2VOTTdH8NxFasncaE8CoDfh
 s1M4P1QufeNWbrKEK6LerjZdQrTec+Lo+mgbo1NQLDJJ5FZAYK5o8+l20TxW9S4VtR1EgKOsJ
 j7omVFOZmDOgDmxqhP02OOTT71hlTk5sNTvHhHKD8+lN4XM19aBQ3yAh80ocDqegYvgPhAnwt
 W/o08SmHFFQoV+1gfyJ+6nlJ9f2cK1/acl7fTTx/6+AC+mARxOgY/9ls2rq1jkCRQo9yd4SL2
 F8l8de+peIXK8aFR8yIlF/CTF1BJbx4tJbTjFvWsmsYdAE/el7dmzPkbGdCCdmcz/oIk5rOrD
 xOfPMYRahdDUg5q2uOJbZqybE/0irijDzArR14VSTdbn4Vg56hYm0SDVfGfw8N6fUrT9MxooA
 LZLDj5o6wzfLxjgMjLmSkZ90Y07OFMHOLg3pgLOzbtp33GH1gxOMvnLR1POWCeXpJaNCw5qDh
 8NEaUIgXC7v/4jmNBar1mOJaNU/HaeU7wq9YWL4YGjxPYhZUs1PB9VUfcgwPm31bNfHBsISGN
 6V6rhL6GCOuksS6l0q7/KXYyTBsF7AcqPFzjq98sfkDHb4c/35tfXAsaZV9xsqSEGuVZr3YBq
 g5VJmXrJYVU/hZE/2+kgzeg37nG97IaIW1HfG+/5gbPFD3eoP4XsR7jT82NqYj9j/4vnZLYcU
 LRAuARPVKPVcZMgvKnwogUo+ME7t8tZaCe+R/Q==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The casts used when initializing members of this data structure mirror
the types the variables already have.  Remove the casts.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index e1773e57cbb0..d6fa2bfb6a6d 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2705,9 +2705,9 @@ static const struct iw_handler_def ks_wlan_handler_def = {
 	.num_standard = ARRAY_SIZE(ks_wlan_handler),
 	.num_private = ARRAY_SIZE(ks_wlan_private_handler),
 	.num_private_args = ARRAY_SIZE(ks_wlan_private_args),
-	.standard = (iw_handler *)ks_wlan_handler,
-	.private = (iw_handler *)ks_wlan_private_handler,
-	.private_args = (struct iw_priv_args *)ks_wlan_private_args,
+	.standard = ks_wlan_handler,
+	.private = ks_wlan_private_handler,
+	.private_args = ks_wlan_private_args,
 	.get_wireless_stats = ks_get_wireless_stats,
 };
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
