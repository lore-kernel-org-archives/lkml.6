Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476714-2-7720716435971240244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476714; b=rYdnyEhF+3aLi8vfpSbiGg0LuCheNGxTEVJS01x1QNyUivkasR
    ze7qDjhzeNxT46CYm3dbrD9GoryDMxFssws8YIwU7h3/cubLu2841V/VTDaHIOtT
    QwuS57JCqmwHJ3vzjPtHaIVb75EF+J5o8FaiSIKjpCuw21TGnYNpwTh6M3jCX3Jz
    YWt2Eq706WjkrlGTTyCwpJA9eT9Jc4nuH3GHps7TMFQ9YDJGs0RrUwSWE4NNot+5
    YtJnwdiCEjfe6NsHh2MRBSzj6oXd1MYCy/OEhT+RKoz3Sa6s5yumpIhaOvtJXJ8m
    L6BDZvJnTANkw6El3f+om+8ZXWrSMorjnfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476714; bh=KhEgA
    1H558UopbGHLhUZxADnjHoon8QC/k8yiJIkzsM=; b=VUhQeAgxKykUk/UjnaYR/
    LCbh3Fgx23pfI6fLYw0eVy38bbjcJrbuGPaWzE6JhwyivuDwjp+DgrhCg3Xm/R9s
    n3nJzISZ4Z9aJgfliRDxeAEYSdQAHIJBcpHmvybSQxBPj4/OIWZBXjQ1Uk4WiRIa
    cFby7t4xYZApSnv6AMzcIsLdnO8Jq4fnk4fMTBVGpNZPczFfiFNU/G/X9DvxYC1o
    QkOtYI43UraOkpK6q2cDlSKNoezx0aT4Rb9qwZaDhWslY3xOPdQf9fX0dgxVrynn
    yDDqJ94pdW5FFp9gvt8Xz5CiRveyfvp1nA6UpKNltHwg0wsuKoW+vIB+pTWZU93f
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ5yE9ZkozUyzvrzdzlns73Y0Heo0W88Rz7XfJK0qX0V/KPnstuAVERmC9U/rqyyaTesiDd2/HVftTDSO9s4m50Ju58+CFZ9thXzuuwRFVVKkmCYyi17
    6H49W0fhQ+TqWIxgB6fmw3//rS15jvBfpB13KpAlflxGXff+cfTtpBLX4CgWUKcQi1smOHq4qM5oIbAddyLpt95/0tk2w8N2Nsh/2orGtytZhDYb7cJrsWT9
    K+0vgjRwyYrBJG8mjOHugg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=MBXM6yTHWV4dAfAIpPMA:9 a=UDQQspEnBvr74pDg:21 a=RXX_uIDLxI47Pdrj:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 56/75] staging: ks7010: Remove trailing _t from 'struct
 local_gain_t'.
Date: Fri, 30 Mar 2018 23:08:36 -0700
Message-Id: <20180331060855.9452-56-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:K498pv6uI5aPfM/SMWm9VymhG08balwQ3fx5FWZ+y2S5v0lrTSc
 Hn683L7UmNMNDsw2Q+Vy0PSnwI6IaQEUGcoh5NG0p03C4IDrTeE3lsG1u5bW2dRn8LFFYqG
 tdqj58hjzWLEq88t8ziIOck4PVmehBDcsHuwaD4Ta0PVeS4zKvvUZV9El94Z9sHXfS7YK0H
 IgOuxab4KJwtnRdIX7CwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1b3hgEhryVY=:KDMuPSoLlRIZRqXww5ua43
 IqqTHpzK6Isd4guNbLJBTx5bNdTYTNwjWoFsI7Ql95iHadq6MU9XghK7KCwLWKrc9d0JJNNXT
 ddtnnyBBn8s/SOB9zNjtE4gHOJ1UjH3YpZvLlGuQx1i9ITfcLNRh9Th1njnKCdgknoG0V1BeF
 nwqQ5KySIpQsaPY+sDVYeRgoerhAiFxRNw2tpSq8rsZ+ZiK/aiSH4XzBqkwrSz1vcS9LO22KH
 vmxGhAFYFzcB3ygilmNWsjG0Ry00VxaRFWvbninF4ifddV06DAiFM5qChiJGlQYVpNVaHEmH4
 iSC6Cxua5JHGy76nP4XyoHUE9gGP9OB9uHhadomx9j1Ah92uStATPZVMxtxmisDy+YYxfjQaP
 xnTnAa5rEAwlimKeKXMr5DLmoL3xlPJQbmDkjeCCcctbJjFidqS4ZAbE4+pltOaFahEtJ0Fmb
 8rVa9J2J312u4hmPtesvXgEVNpSIDk47pN0F6ytlUKy7vBZAdj181BLdo4nxS+z+bCNZgnmMM
 8SH3YBCvy6idgdVZcM543bLed5c/hvUfvvVFDW1/sbgPc7APGBY1kkiFjWvYeKrumvjcbOnXV
 oRqsRxbyY8Hc04xXquDQFZKwq2ToFjrAZ63FphAZFf1ZuN/f4bj3PVAvDAl9/EO/QpWK0PjYF
 eJ+q2rWoT/IGpb+XuIKCJfcFwpB1M23eNpSdi3tdxch8CHeJdoj4FS2SoBdsjh/jZQSqppsmr
 l+iqIekHjNYorxKjcLBOdduajXuc1mlAneBYH37iDldJJmkrUj2rjZmUDoauj4pj3taP/1q0z
 eEv2voFFQBgmXFpwbkAh9FCLwn3MDGjUU3HMN58J4w94Qh/zb3VHZnhkCDe2mYJJaAtbEUy1E
 f25d1NiqjeByl0F5rLt3cKNASyaFJaD297M8rinOUDv4WtpNmVWR/hcFF4lnRS
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct local_gain_t' with 'struct local_gain'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 57b21d3a2435..e6c4a0fece54 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -249,7 +249,7 @@ struct local_aplist {
 	struct local_ap ap[LOCAL_APLIST_MAX + 1];
 };
 
-struct local_gain_t {
+struct local_gain {
 	u8 tx_mode;
 	u8 rx_mode;
 	u8 tx_gain;
@@ -471,7 +471,7 @@ struct ks_wlan_private {
 
 	u8 scan_ssid_len;
 	u8 scan_ssid[IW_ESSID_MAX_SIZE + 1];
-	struct local_gain_t gain;
+	struct local_gain gain;
 #ifdef WPS
 	struct net_device *l2_dev;
 	int l2_fd;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
