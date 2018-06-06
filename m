Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BEA160555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeFFRJH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:09:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752257AbeFFRJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:09:06 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v3 0/6] add support for audit container identifier
Date: Wed,  6 Jun 2018 13:07:23 -0400
Message-Id: <1528304849-31826-1-git-send-email-rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for audit kernel container identifiers to userspace tools.

The first and second add new record types.  The third adds filter
support.  The fourth and 5th start to add search support.

The last is intended for debugging and not for upstream.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-userspace/issues/40
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-kernel/issues/91
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID

Richard Guy Briggs (6):
  AUDIT_CONTAINER_ID message type basic support
  AUDIT_CONTAINER message type basic support
  auditctl: add support for AUDIT_CONTID filter
  add ausearch containerid support
  start normalization containerid support
  libaudit: add support to get the task audit container identifier

 auparse/normalize_record_map.h |   1 +
 docs/Makefile.am               |   2 +-
 docs/audit_get_containerid.3   |  25 ++++++
 docs/auditctl.8                |   3 +
 lib/fieldtab.h                 |   1 +
 lib/libaudit.c                 |  65 ++++++++++++++
 lib/libaudit.h                 |  16 ++++
 lib/msg_typetab.h              |   2 +
 lib/netlink.c                  |   1 +
 src/auditctl-listing.c         |  21 +++++
 src/aureport-options.c         |   1 +
 src/ausearch-llist.c           |   2 +
 src/ausearch-llist.h           |   1 +
 src/ausearch-match.c           |   3 +
 src/ausearch-options.c         |  47 +++++++++-
 src/ausearch-options.h         |   1 +
 src/ausearch-parse.c           | 199 +++++++++++++++++++++++++++++++++++++++++
 17 files changed, 389 insertions(+), 2 deletions(-)
 create mode 100644 docs/audit_get_containerid.3

-- 
1.8.3.1
