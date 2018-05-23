Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932831AbeEWMRh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:17:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932786AbeEWMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:17:32 -0400
Date: Wed, 23 May 2018 14:18:19 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 0/3] bpf: add boot parameters for sysctl knobs
Message-ID: <20180523121806.GA27675@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some BPF sysctl knobs affect the loading of BPF programs, and during
system boot/init stages these sysctls are not yet configured.
A concrete example is systemd, that has implemented loading of BPF
programs.

Thus, to allow controlling these setting at early boot, this patch set
adds the ability to change the default setting of these sysctl knobs
as well as option to override them via a boot-time kernel parameter
(in order to avoid rebuilding kernel each time a need of changing these
defaults arises).

The sysctl knobs in question are kernel.unprivileged_bpf_disable,
net.core.bpf_jit_harden, and net.core.bpf_jit_kallsyms.

Eugene Syromiatnikov (3):
  bpf: add ability to configure unprivileged BPF via boot-time parameter
  bpf: add ability to configure BPF JIT hardening via boot-time
    parameter
  bpf: add ability to configure BPF JIT kallsyms export at the boot time

 Documentation/admin-guide/kernel-parameters.txt | 28 ++++++++
 init/Kconfig                                    | 90 +++++++++++++++++++++++++
 kernel/bpf/core.c                               | 31 +++++++++
 kernel/bpf/syscall.c                            | 16 +++++
 4 files changed, 165 insertions(+)

-- 
2.1.4
