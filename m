Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeEWLfD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:35:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932529AbeEWLfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:35:00 -0400
Date: Wed, 23 May 2018 13:35:47 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH 0/3] bpf: add boot parameters for sysctl knobs
Message-ID: <20180523113542.GD3888@asgard.redhat.com>
References: <20180521122923.GA15717@asgard.redhat.com>
 <20180521185811.2r6372timh5rfs5n@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521185811.2r6372timh5rfs5n@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 11:58:13AM -0700, Alexei Starovoitov wrote:
> On Mon, May 21, 2018 at 02:29:30PM +0200, Eugene Syromiatnikov wrote:
> > Hello.
> > 
> > This patch set adds ability to set default values for
> > kernel.unprivileged_bpf_disable, net.core.bpf_jit_harden,
> > net.core.bpf_jit_kallsyms sysctl knobs as well as option to override
> > them via a boot-time kernel parameter.
> 
> Commits log not only should explain 'what' is being done by the patch,
> but 'why' as well.

Some BPF sysctl knobs affect the loading of BPF programs, and during
system boot/init stages these sysctls are not yet configured. A
concrete example is systemd, that has implemented loading of BPF
programs.

Thus, to allow controlling these setting at early boot, this patch set
adds the ability to change the default setting of these sysctl knobs
as well as option to override them via a boot-time kernel parameter
(in order to avoid rebuilding kernel each time a need of changing these
defaults arises).

The sysctl knobs in question are kernel.unprivileged_bpf_disable,
net.core.bpf_jit_harden, and net.core.bpf_jit_kallsyms.
