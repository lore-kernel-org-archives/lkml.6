Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3658149-1525410101-2-13727347041189925472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410100; b=SuoUMxx/9E3aU5BKFqD7LBfEGMg8ULCfpVSnq6+FS4AthozZsU
    kUgW0lnCeIOy7XKJsiljpa4cyi5fRp6ibS5OsJOIpGMYf89bhv4iOmFPyrJgw5Kk
    gp5RqevG/SCp98EVJGYdPo0XtDf60NUMDB0m6pVdo9CXrk2oWUbWs1GfPj0TJxOC
    ckmofQErnBEpM3t4ZakjoonVlShtg0hEXBvD5N+JJ3T4NMxSSGwimz3OVFAqMd4V
    AJxCIF0CNdZuCI2DpiO/VedH+PqKM8quetAHLxsNXhHrbUsHmumQ7uXMH4q5fdS8
    cA6+lG8Vhc7etUyWf+bP9jeXJ5YZajhSFL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410100; bh=egvGr
    Pf6RQ6F3lkIyUfzbMvyzOCo7c1CfoUuCuHQosI=; b=QpjpfugYVlx1nDq1O4Y2m
    GD6gFrfb65gLFgG8dcBjK8ciaXaQxg9YJ8bWH/AtciqKbBJ3vPW1IxZFhV+jQlcb
    jjB/MicyJw2NFY/J8RbFdy7miPEuyEgG2wqCw5Zb2SH7kH/wDVTEHPMIuktdKC8v
    a4xFiuqPdC0dEY758bwoe6+GNPPQO8+uruU1ceL2efw74y+IQnsjXHwR5MrN4zSW
    j+hiRQzgF06x31oaX9pCX6p9SPyi3E/YIfmw8/VgzNynln8vnUL7/h3WzTQIOZMO
    aSD9yhsH8jLJUDJc7bsZsSlK3jqBH7BxyDeakyjoLpPpR/fQi9EugtXU2+maV/sa
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=brown.name header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=brown.name header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBQnKjEGyW3iypRbT47rN8I2dNhAkvNYEGVDk/q8OH2knvZfPBohCYvzKrEtYUnwYgYim07/uQdBhWKCnBwLZvEVH+/bCXD6AIcVmtD1o8eDi2CRXZTD
    cXtx0T1M5E3aGaTEMH4P17vAeYQJcYI0D4rpDhzsgK5Kau+nMIl7o2w00sTzT5shq4Rv7UV6r1EejrgrWlQWJQpM6RCmXDDsY/jo1DTdSPFrPUvaA6kzrKvZ
    R/pv7swo4xz7B1MDuitlNA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=toaIDTyABDVEnC2DrgYA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:36 +1000
Subject: [PATCH 8/8] staging: mt7621-dts: update nor-flash info for gnubee1
Message-ID: <152540991638.12190.9801236161993726987.stgit@noble>
In-Reply-To: <152540982998.12190.15220622955317261586.stgit@noble>
References: <152540982998.12190.15220622955317261586.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The GNUBEE has 32MB flash, so set partitions accordingly.
Also remove "m25p,chunked-io" which isn't documented or
used anywhere (outside of freewrt).

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-dts/gbpc1.dts |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-dts/gbpc1.dts b/drivers/staging/mt7621-dts/gbpc1.dts
index 515c7cbdd15e..6b13d85d9d34 100644
--- a/drivers/staging/mt7621-dts/gbpc1.dts
+++ b/drivers/staging/mt7621-dts/gbpc1.dts
@@ -75,7 +75,6 @@
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
-		m25p,chunked-io = <32>;
 
 		partition@0 {
 			label = "u-boot";
@@ -97,7 +96,7 @@
 
 		partition@50000 {
 			label = "firmware";
-			reg = <0x50000 0xFB0000>;
+			reg = <0x50000 0x1FB0000>;
 		};
 
 	};


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
