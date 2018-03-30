Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2915802-1522393790-2-9848428439736502608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393789; b=bIp9h4MqRsnAKV5XqEbt5HHSKQSxvnj5Lg5gRvUdVOo51qhJs8
    mVQVCnVqoktRVVzgcgt5xJ3E+HEUIrpJ2gMZSBinKeEWLIaQ9l58W44okI0vN43U
    THzvcS9M4P1IqSb+YaIObXHDRJ+LzscMe9THpPOc4TmNor/va65oS1YYeiOXaysd
    ROky2tQxIgO+bEEd8vtzFboSW0vlyZDM/NbitTg1GkHihs44N0tlD37FBdHpj+qx
    kJZmdeJVY/R6Reo+/GjdoRDLyZHiSrjkIm4JIg4Msl+C7g2vKI6VnmftxRoz3mZW
    +zSREKEPD3nGY9cyqRcvB1gxzL5M2rmsuvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393789; bh=2kXbm
    8StzwGe79rt38R57YHcgRRPeynVzssmSXXHCAo=; b=uiXC37MFsdqla0bpeR1Vb
    xYqGo/Q55IgPjwvmzKYe2NtB18U6oaO5CZFU50xkxADaqUe33RA5yIx3ML1ug/vm
    kp/V/EWiypjoAFQrCpeUXERrD9PF/apB9ammghQV5HU2q0bo3lwWltF61hbARvag
    b8J+qf/R+Ieasj9MZpzLi2bG39mvnnPUzBjN5lW1Yfqrn/BlY9romr3eIzKdjMMX
    3RLffr4/vO6i51bHQRW085KOMWwZAbC2IMdJcBD40vsTOkkosPfARf/2XeFIXsUF
    uNIvjHzGos1riXiBbPQcPYk7yR6VAyWCaZltV6jK/h95VzE+GbgWNT/fb2/2lijZ
    w==
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
X-CM-Envelope: MS4wfAjs8DXiqNpqPW8/FaYAUe7wvRICRO4Bk3PRuEQmqsMTVQW1S4wivhxepv4QmSj11/0+Wiy22+bn4JNp2f0HTynMzbq/zucXUCz6LOYqeZbg7YT91MyL
    TjhfI1EY4YLXedKxm5S7D+hYlD1qRKn6pYe9TJXr6EwE9Yv5tvEtLF+ZUgXzuBapzDFKJEPDkG2WK8clLrFg1g1I1FZXyMqXKvbd8x8Det3+hYAGaHDGdwxl
    j37joOGMkRTOlJrEy+qXeg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=gpGHsg53_5QM18PxnzIA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 14/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_power_mgmt_confirm_t'.
Date: Fri, 30 Mar 2018 00:07:37 -0700
Message-Id: <20180330070842.25224-14-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Qy0Cflwa4sL0J/+d0r8Zcv1TCc/BAjxJDmQ9kJR8d+Qk6E28KlQ
 16X5WHUana5AKBGETrX8CR/stn9r/quzHEuwVvIHqyMvP8uzoP0fZY+5Joudojz7dbgUH/v
 Vk5E78yFgWBx/nvLwi7fUXdGRXoM+OhtUyQCuDMVvlI+Y25MKQU69qBizWs/sjMU+K0l2T7
 GNs7HQwEV3hxRv7OSVGMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K0nFm9XZNPw=:JPJeXBRP+INSe1hm+K/Rr4
 3uq0UIhoppEKwYxUxtL5lnJUILk94V5cJgaeiuKS+6WgBMKSJOqs1tyTJcvvMbIpZEwg+8Gms
 FSpcmXK7dkpBSvcvU9M4KtDWDqLGpwpcHEmvmlMxo9nambLP+bU4WK1AI3F+s4KW3A4JZ0vaQ
 E2U6fzNNRmrQZUsKLszD6KvgUJDHjOgklLp3VF1T2sEN2Y/SRx6b1Faggodg/hbR+If3huf+6
 BvwlESUby15EMeSutQv8zMPAId7iEM5DQJiz/DaSsllAriDWsqlkJ1SGa8e1h2xaA8Fxg20C2
 JVzVnAkT+y+1EX6bIBwloG/2gpMDy6DkvAoGqXDlBUf9SgM4l0naEyiBdgTuhdqRC1wD1prHo
 eHDlmMItyciee1jHrNEvew5dtli0oGOX+O4PLtiTKbI5t2ez7b4htr6NwgC/IHlK5N9qAE+hx
 Ojcl2MZRdKaESqpBPO6h7FILr0AQQovSpjkNPKBmlmaUsjVWczw8Hb7025SJlX/AalorMWV+q
 44YxEmsO9ctiwDsyhd0wm8/GI3AnW7CYvnClGirXUpArcClrscdGZRCmKjhSNc0v+loqqaGGm
 HNDy3QH8lUvLvfB7zdhRTXxd5mIEjtkp1nMqin3MTgwhyuV1Fobq6FrPgpTJdio6GkK5USj06
 rSXsa6WZYrnIvhL69Oj8WCF5g/cFUk8AY13R6ANsYbTDWr3Rf5CpxI/mYkeqGw4zKohlt9a6S
 RGAz+Ub3dlc+Nt2iSoo1xnjPUxMUQEl+g//x2Q==
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
all occurences of 'struct hostif_power_mgmt_confirm_t' with 'struct
hostif_power_mgmt_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index cd23ed67cd45..e0219fa6d4a8 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -206,7 +206,7 @@ enum power_mgmt_mode_type {
 /* #define	RESULT_ALREADY_RUNNING    3 */
 #define	RESULT_ALREADY_RUNNING    7
 
-struct hostif_power_mgmt_confirm_t {
+struct hostif_power_mgmt_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
