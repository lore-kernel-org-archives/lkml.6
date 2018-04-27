Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840059-2-13422865996147221701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840058; b=DILkDWjrNQMRiHjtCw7IaRKm9W39qd0DxwT5cz1pYJEST1CAZv
    mrmp1lNB31wT1H7OdiV9R3+tfpquVnlRcPU1dkv3y8RUybubpfEzfv6MIUVNeIa3
    7fwSwZfM74yo2C0Ebhydu04s3HMk7UVM+JnpYec9m1RbCFBDmWe2iMIoPnvW1G1p
    UUl6tkFzCVBiQeWgPYBb910UTsW6smZGhv6hM2Vte9KjMhKP/onNrVC6wIK0MbGf
    EciU6OOjIZt0oACXUU36EFsetdN79u2J+/UIsRX2v6hcuT1XrGduLcA8S1llr5Pw
    eyKwRRMz21Ll+w4TB08VqMrA47mvXmRFBggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524840058; bh=pIpbV
    ME5Uul0bK5zYjdx17CfTMePiGQXwU6nJ32hAe4=; b=RZMPz4gQeYTZvfobG3DFh
    SPSK3UCXGoPS5MRyb8+Hh6xlGnhghqgdde3aTFv7pMxnikjyGGpZ8B6yBcIvkzpu
    CYCAoA19bShWhkXVNgiSWzBGoHs2BlZMP2kaDCkczu7l7piL1GQgrW5TClrkkPJZ
    Aqsx88immprnaaG17J3npv1vIcsrH6AOZZpFn4CvE3weajuNIi0Qiz7n1miJ91Nq
    8aqlz0kNkCm6TCCcji8JQ2zBoZ9Wvy4epgx7NM1wibd7ljbHmUjhxvK3hHzfsyN2
    Tfg/l30mQvnv1l3wOyrcvFWRnMg3Pxx+/KMmzTlFGuWcPdtduuP14t6GTq188sqq
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtM+zHT9MU+qnq4e2oL8IcBoCloGqWPdsVqBYUBSyXf3DNIt9VD5R6ga7ceXkq6HstdmezYVavZwtB4zRNT1y7tKXGZBlo+m3vcc0clU/xyiisMgezu
    21ODg4SiGsLnkkWj6xTflRXAaOYDCGCMovYnjCw+v/UkMxgzLQQP3FgIm20Mm4IBvzQWPqPcBkASofDGjAUpFpkl4/CttI6P3+vTw1shuAY3n8wVc3RFdjLz
    e2ldn48Fu7Fd7RQhyuqEXQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=DDOyTI_5AAAA:8 a=kdtI_ITTfTbeFUV1G5cA:9 a=6uaAUPVJPgh43_ZW:21
    a=-9c9o3VL7jwkzKvd:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787B021895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org;
 spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 16:40:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Staging driver fixes for 4.17-rc3 - take 2
Message-ID: <20180427144043.GA9154@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now with the correct message:
------------------------------

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.17-rc3

for you to fetch changes up to b00e2fd10429eddf4a181ad30af010e56c2303f9:

  staging: wilc1000: fix NULL pointer exception in host_int_parse_assoc_resp_info() (2018-04-23 15:57:38 +0200)

----------------------------------------------------------------
Staging fixes for 4.17-rc3

Here are 2 staging driver fixups for 4.17-rc3.

The first is the remaining stragglers of the irda code removal that you
pointed out during the merge window.  The second is a fix for the
wilc1000 driver due to a patch that got merged in 4.17-rc1.

Both of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Singh (1):
      staging: wilc1000: fix NULL pointer exception in host_int_parse_assoc_resp_info()

Greg Kroah-Hartman (1):
      staging: irda: remove remaining remants of irda code removal

 Documentation/ioctl/ioctl-number.txt      |  2 --
 Documentation/networking/ip-sysctl.txt    | 15 ---------------
 Documentation/process/magic-number.rst    |  3 ---
 MAINTAINERS                               | 10 ----------
 drivers/staging/wilc1000/host_interface.c |  2 +-
 include/uapi/linux/sysctl.h               | 18 ------------------
 kernel/sysctl_binary.c                    | 20 +-------------------
 7 files changed, 2 insertions(+), 68 deletions(-)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
