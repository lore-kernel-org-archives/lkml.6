Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2591082-1519251959-2-5305837329467479643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519251959; b=SoTy8c7o1LU6pJHSB8ZTLoD0ysnzweZO1/jqfsSN1BfYDRB
    BtCUZdpXXNNsAwwGIENXWeXpdWZp97rU3CB1RDH+E2ruRL3LBi4wLomfrkheXSpa
    jgQoQDmKMeeilH8Ang2W6iKCBoWqvLkrlIHVvCjIGKbVAS9qqALSw/u8vwS0Rlox
    rsB+czJOjlWVHgP5u+C890qz6BvMO1vNlOwNt2AXhzpwP/wStX6cawF8dbYCMLKM
    CXn3Ob/NaCCRFFEj0hXv5usDI6Tms1AZ13vKoZeIINFAxXW7NChMuRA69ZHnCNe7
    wFqsnsI1kw58VJjS4p34BfzC+snnGWBb1bPJe4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519251959; bh=9
    Y4Dd4CKtMm5Vk4Lmwv6zW54wZq77aRek6l9UK3dbZw=; b=Lww5IHQbq1wPhvb7r
    JAFhiRyLRV0vK1X7uiN3H2gKz1JFA8uK5vbYWVAik0l7195UjjjGQFOooUtbE6YZ
    U1dTPCm5lSX8Elj9SdYqJnLveK5L0QP51hFz89PATRSifW82uo0BSE06++py4ZFk
    XlsxQBzh1ofsg8ERKwChMEwgRxYHOlGVSwgJ+OWHH7PJm8y5oVqd4uQpPL+fwclz
    GDgU6ymck1fo7bMemURqDE3Z1VQDtXK+zwWjzDxTYQnEtkwR8NT/eEkaO5gm8oLL
    kZtn6QyD5uQPOhKkTwZrtmIdIQCp4Sgd3iRo8TxERh2gss6kN/E5BhvfiJrfy/b4
    3hN+Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CtAGraeH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CtAGraeH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2250jNqj9Rn+BIyy8z7oiqXaGeQCpzRZSDsBLD+c3hKXozG5kNS0e6+KuYAgiC4eoN6l4rqRjA==
From: Laura Abbott <labbott@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCHv2 0/2] Ion unit test with VGEM
Date: Wed, 21 Feb 2018 14:25:41 -0800
Message-Id: <20180221222543.13633-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is v2 of the series to add a unit test to Ion with VGEM. From v1:

Ion hasn't had much in the way of unit tests and fixing that is
something that needs to happen before it can move out of staging. The
difficult part of testing parts of Ion is that it relies on having a
kernel driver to actually make some of the dma_buf calls. The vgem
DRM driver exists mostly for testing and works great for this case.

Changes since v1:
- Dropped RFC
- Feedback/review from Daniel Vetter about DRM ioctls

Thanks,
Laura

Laura Abbott (2):
  selftests: ion: Remove some prints
  selftests: ion: Add simple test with the vgem driver

 tools/testing/selftests/android/ion/Makefile      |   3 +-
 tools/testing/selftests/android/ion/config        |   1 +
 tools/testing/selftests/android/ion/ionmap_test.c | 149 ++++++++++++++++++++++
 tools/testing/selftests/android/ion/ionutils.c    |   6 -
 4 files changed, 152 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/android/ion/ionmap_test.c

-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
