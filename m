Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676BDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2973B2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Oy8s3hhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2973B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeKGXT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:19:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43110 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeKGXT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:19:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id y3-v6so17172334wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 05:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJ6ZT8E5/I+O1wiMOAR9lKmGCXZmgtKp4kCHVfIL2j4=;
        b=Oy8s3hhgyzVgyIiOzCyqpRA14stnzybiMKyY2OaXtZEfahTJpk0hPolFrYiv9bEl4Z
         xBq1uj+trqf0WmQC4xTlImUrcOgRXo5FOlZwYT8EhsmZwshUskAkVQyFrU+1ZSI8gA3a
         gFnFjkd66VKny8RO+xhfHiqJ5s+JYMREFGjsLFTvVB3VCKWiuTvcqqK2oPTiQyLTRiSu
         tvBS+p4tMJxLI5AQzsuXR6LoSihLYmnbQrqWzn8XMfTgm+av/X7HZjOuRSiK9X5sjXaQ
         FYZd/QoRY1YxwgPzBj0DJEGyUiIpqeOM74qzgECyjInmR1ZMt5/8M2SzMOZBBqdf6VvG
         YbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJ6ZT8E5/I+O1wiMOAR9lKmGCXZmgtKp4kCHVfIL2j4=;
        b=QJAyLEclN+D/7aFR65xqO7e7xO4/WDoFV8hWMWABibhLDXPwTa/2AA/fQk/9ynk1k2
         KxWS9cgjkf6+/EBn3KFu9zxdoSpjl2GqC6FJ83SSNY2HUCeONDLQhhrOaEpjAsJFiV4b
         1kAF0FWZPE/BI7wTZ/7FV5dzSbdQ2oWijG79HnFMrEqJbMwRlNl79hBh1rUGFmktzjK0
         3MpSzKWTo99C/ViNcWeMLOxvJRvmCbN7lJ8O+DfYB00ccdlOmNbdHA0144gFMtgxpVn/
         f714WnwJlDa4nrERMd7D03m1wEBjBMN6du+J21ArzAqD2a+zOymNjOf2zpSyyPqpzYuw
         Jzhg==
X-Gm-Message-State: AGRZ1gLI2A8UNsYywrnEm6nFbZ08k4yw1Zta9oDpn/M58aNA+T7vA0qv
        pgDO1h82fcy+w0bL5cdrXKNs0A==
X-Google-Smtp-Source: AJdET5dlST3cQtiSQ5GYlcBB+jYQqnEyC8JuMqurohwDQMQDNzNMPsXAKvlJ5AlZ5w9FrzIf5gKOcA==
X-Received: by 2002:adf:8361:: with SMTP id 88-v6mr303071wrd.192.1541598570442;
        Wed, 07 Nov 2018 05:49:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:8070:8895:9700:887:8ecc:df73:24eb])
        by smtp.gmail.com with ESMTPSA id y83-v6sm1206778wmb.20.2018.11.07.05.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 05:49:29 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org
Cc:     tyhicks@canonical.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 0/2] br_netfilter: enable in non-initial netns
Date:   Wed,  7 Nov 2018 14:48:57 +0100
Message-Id: <20181107134859.19896-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

Over time I have seen multiple reports by users who want to run applications
(Kubernetes e.g. via [1]) that require the br_netfilter module in
non-initial network namespaces [2], [3], [4], [5] (There are more issues
where this requirement is reported.).
Currently, the /proc/sys/net/bridge folder is only created in the
initial network namespace. This patch series ensures that the
/proc/sys/net/bridge folder is available in each network namespace if
the module is loaded and disappears from all network namespaces when the
module is unloaded.
The patch series also makes the sysctls:

bridge-nf-call-arptables
bridge-nf-call-ip6tables
bridge-nf-call-iptables
bridge-nf-filter-pppoe-tagged
bridge-nf-filter-vlan-tagged
bridge-nf-pass-vlan-input-dev

apply per network namespace. This unblocks some use-cases where users
would like to e.g. not do bridge filtering for bridges in a specific
network namespace while doing so for bridges located in another network
namespace.
The netfilter rules are afaict already per network namespace so it
should be safe for users to specify whether a bridge device inside their
network namespace is supposed to go through iptables et al. or not.
Also, this can already be done by setting an option for each individual
bridge via Netlink. It should also be possible to do this for all
bridges in a network namespace via sysctls.

Thanks!
Christian

[1]: https://github.com/zimmertr/Bootstrap-Kubernetes-with-Ansible
[2]: https://github.com/lxc/lxd/issues/5193
[3]: https://discuss.linuxcontainers.org/t/bridge-nf-call-iptables-and-swap-error-on-lxd-with-kubeadm/2204
[4]: https://github.com/lxc/lxd/issues/3306
[5]: https://gitlab.com/gitlab-org/gitlab-runner/issues/3705

Christian Brauner (2):
  br_netfilter: add struct netns_brnf
  br_netfilter: namespace bridge netfilter sysctls

 include/net/net_namespace.h          |   3 +
 include/net/netfilter/br_netfilter.h |   3 +-
 include/net/netns/netfilter.h        |  16 +++
 net/bridge/br_netfilter_hooks.c      | 166 ++++++++++++++++++---------
 net/bridge/br_netfilter_ipv6.c       |   2 +-
 5 files changed, 134 insertions(+), 56 deletions(-)

-- 
2.19.1

