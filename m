Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476681-2-8132295348457371607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476681; b=wpKxNTdjrC0nIpmo9XwiwPmtLVCfg6cO4iDcVXWQLWNZHPZC62
    YZhSxvpV1hDgX1VmnFvXPVFKR8/p00wMaEqXEnrMLtKtH76Z+0/WFgp6uzbKRt9L
    LtB9oH/WvibHtzQRKZY5Z81tgXk0mmbz4CXC0Qj++N6g9otIotuLNic3BeME1iN7
    HvgqKGwd9M0qT3McNvRKxPjinRD0kZQAF2ZstNCVMs+xZcGn1F1DFp39eV3CxipC
    SSKC+Cv8hBll1RLUiJJcCxFlKrgT3qfMDWsCxDLfBmPLpn3BODUB1+DoKXacfZPL
    3T7HAHD+YyrY7E5yytLxYDYLWrT/61yCLq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476681; bh=vRmSD
    R/f95forHBDVoq+dK3bu4JAb0aakql1q4xLwJw=; b=jy0PA4Dq3byu3DQY9Y+c3
    4L5Jfy71WOyFLc7h5F8OEGY3k8cQtVHJJudT4lji7lHOvJKYP/hIerMdAnvHUBP2
    savA08TpNLBkl0TeC6AiNYYj9yprsfgqjHeeHCQwjpK55UL4PkD4pVlKNMYqKFTx
    WF6MpnzbFHxvKCSyI+Z/Ef40GHylsXjGLBFDViuyOEWfwcR387xAlFgsUbQDFqEQ
    wY1Wafegma9eFZ/eetcX+rs0eE46lNl8ZGU1camjHsy0XbFw9SCVDWnYTiiSXbUy
    xWm2AiN7vuMqbOIE7mNzoRowVG77mNskuOlesk0T6wbUheA62gl6E4XwVE0PW7as
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNerk+bLjQMXvV/t39EMNuzs+qOnVBA7j1w63mU8LGyEjmGY1MOaJvRBkOEoaPu6KCqE6J+TGrslVOpUcnjbHdvIJYyKwK8XWRuBrxoqdq3sjmSnAsR0
    Ir72MSPAFy1VSe0D7qrT9WLK+JHZl1vfTu3iWC7l+YL41r8pINReKlF+gwX+6xO/JPNsnp9s8IOBAnvTCcZBW3vAtFxrWXr0uV3egc/od2lE8rOXKq+IAAEj
    FEH9g3Z6skvlhgj61DuG/w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=ss0nsMyGDnUc0n54iJ0A:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 44/75] staging: ks7010: Remove unused 'struct
 hostif_bss_scan_confirm_t'.
Date: Fri, 30 Mar 2018 23:08:24 -0700
Message-Id: <20180331060855.9452-44-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Vbg4o9py8PtUQf0zVrLnMR41HLBA7upx0lkmP6GFfnos99Ln9rS
 2aXlRqiv77EbTStnstjtWI9+N2CD02ZjTsQzsszJZ7P42QXy9TL6VyLEMBVIj7emb2CgnJj
 HJfj0YzKjhqnBu15OUXowepZdueoCdsno9PvcdZKPp/iQa9IsFDn4XB6SPNVX0wNpuk5wdu
 hhld1lwlsf0BleLhGlPyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rw6zpJElKyA=:kTkAlmzuMjCmekh7NvRhgD
 eUYP+G733qWsJLn+n8udeQJLtH4M9Wbx4bEunsyOZEmHmbNwW/RRt8LP4gMmyhm9W/Bq6sbtS
 L5PGP4PjoY3zapxB3ADUFiUgVz7S7HUHn6o+6/xbq4v1e0D9PYC1j1myDum5leNMYUW3Jb2Rp
 C2lEE3FUd8qGU7261LhSEu3w0DDpi0DQGdMa2DmXM7YTofoYaGJcHoQonr3F2JSmSXLtfVBTA
 j5SxsKtKJHttP5905D+GJ3k1vK1YsahqiDmmPhF8X7o0end4cJIVKVzvkOWDO7ACv5urlObS4
 jjyCsSTTB9I16M6GUZmr8ao39Cs4ZFUOZYCdaj4gCEOGIgeIIbWmd9EKI954UmFlQn8liGkat
 +RLPotF6t1O8RTdSzIhx6V/MH7BObHgLa0suflA/1vxWW0bH5AiD22C4Uosh675pz+gYq1jjX
 wUniVwVgRFQDFVI9NN76BH2AXLTwJ4pgfRL6zN7tnzYssfMj/AuUmFFllaA/rKMwNTWnPJYij
 JQ7I4JOBKpFEBh68Gi2ElHYAiRxPdhVE/2OR9Lrtf80DfuRGP8nSTREsvqEkl4JvVTJ9t13j5
 j1dru4PqTpjNFdkFLB9ReFglqIqb+K2i1NtLuDpTOkSr45HeO3wgQ7ov//9eaEhruJEv4APtL
 /mpQ1Te/Dcp4BLe3tWuXsTYNAwJ4M9zDYAi/O294eXNj/C7oPbA+go/olhjr5wrtTv3zBkTzi
 YI1+BjBiFxqm0k7khNr7LPLA5ybAgKPDLh3QxA==
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

'struct hostif_bss_scan_confirm_t' is not used in this driver. Remove
'struct hostif_bss_scan_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 7785e620e03c..1aa4da0f5403 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -401,12 +401,6 @@ struct hostif_bss_scan_request {
 	struct ssid ssid;
 } __packed;
 
-struct hostif_bss_scan_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-	__le16 reserved;
-} __packed;
-
 struct hostif_phy_information_request_t {
 	struct hostif_hdr header;
 	__le16 type;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
