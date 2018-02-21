Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937370AbeBUQqb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:46:31 -0500
Received: from mout.web.de ([217.72.192.78]:60275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937333AbeBUQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:46:28 -0500
Subject: Re: [PATCH 0/8] target-iSCSI: Adjustments for several function
 implementations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Arun Easi <arun.easi@cavium.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Disseldorp <ddiss@suse.de>, Hannes Reinecke <hare@suse.com>,
        Ingo Molnar <mingo@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jiang Yi <jiangyilism@gmail.com>, Kees Cook <keescook@chromium.org>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tang Wenji <tang.wenji@zte.com.cn>, "Theodore Ts'o" <tytso@mit.edu>,
        Varun Prakash <varun@chelsio.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <6163538d-a406-2f60-11a2-88b4694e9975@users.sourceforge.net>
Message-ID: <c9a822a4-248e-c479-9118-4b8ffb1033b1@users.sourceforge.net>
Date: Wed, 21 Feb 2018 17:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6163538d-a406-2f60-11a2-88b4694e9975@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:TwTcJgJSxsKRRRG0Xx9n+NRa95VJwWzCO5f/+XeJur/3aQ2XE58
 B8vQ0tWOhIjv+NEQxYA0gR8uJ7pYs16PcLfH04fummO7MZrBjCCQ7ZC5VgFgg2D2qE2mdTl
 Y/RZs4BJu1wwGwO06cueb+0nxRAXRQsDVDDDfxnmiWXXmb5FsU/7eBWUoQ2e8qXii/i8AvU
 n89DM9e2Z13kcfAp/v2Sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ByfTpxme3h0=:sMt1o4zlg4fIKsv3OEOvRj
 LmB/sTpO8d2bY8yAvXhaeVSqhNRSiI8ec7Ej449lSSk92PNpXiuB03Bfzw7oK2ozRmB3BazkW
 u5hYel6wYa40/ntvPg9Kc3Y+S1y8iozCCl5ZHogq8oxwuimIDBHrPn08i15A3u2XQctmPSsZJ
 635DOWs+FKA6g5M9RKaVwYlrnKboWZ7yPM5y5l8bXfhYKNs/lVQKwfvI3Nez3vmshBWjIeOay
 n1ZRQbq6tntLdkRJfz/kucGkPYvLI/RmkQIHH9VM+GLGV4qPWCw4U1Gyf30X3zJ/NdoNaLOAs
 3LX+QK9eawVXEO5hUID6Q9OGcmMeRjcx9BlHTOKtw96OjB6/oQ4uV27MZvIoiQcSPiSTdQxgy
 NG/UOTTWkbxSb2WHtrBtPyez0TwhYGGOR+gHSviNOPi3issCZ6sWOOyIhQUmAfrXN2eomDPWm
 5Qckco5h6UrcRylJdgCH6VrpSnbip5DNKHQrSx4AoQvq2ul3dFoHZDO9f2Y8FGLdB3A5Q9pIR
 nxhNXQVmjc5tuQ9Y4PS06eBo6qQkw11CJESRmSHdBCaXfSXG2d4TmwyqSBNWAvpu34JwK6pIu
 F2jmS3Fu8MczRK55xbTLbrQrzAqIi8HwDebtHlZxYR9JS0OzHLf+CFAVzAN5qY6HlLYP0Bqrk
 97LQrqTMqYlCGutKyJ+ES1xLlc3ebp2+EKiVed4DE5QGR5FVjl17MkcYfWtkp5s9p2GG+0wRy
 5i2oBjRPTM49PMaOFO1E84Sjm5Q609E6834GchB9c4QnCDhBSfZr685EXTMEmyJ+rRKLXgQ4V
 O9u7bUqrrq4lYqZG/DlDczL34G7RH+m0aod4bpTvsNuimwA9r0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 12 Dec 2017 22:22:11 +0100
> 
> Some update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (8):
>   Less function calls in chap_server_compute_md5() after error detection
>   Move resetting of seven variables in chap_server_compute_md5()
>   Delete 36 error messages for a failed memory allocation
>   Delete an unnecessary variable initialisation in iscsit_allocate_ooo_cmdsn()
>   Delete an unnecessary variable initialisation in iscsi_copy_param_list()
>   Delete an unnecessary variable initialisation in iscsi_create_default_params()
>   Delete an unnecessary variable initialisation in iscsi_set_default_param()
>   Improve 16 size determinations
> 
>  drivers/target/iscsi/iscsi_target.c               |   2 -
>  drivers/target/iscsi/iscsi_target_auth.c          | 110 +++++++++++-----------
>  drivers/target/iscsi/iscsi_target_datain_values.c |   6 +-
>  drivers/target/iscsi/iscsi_target_erl1.c          |  14 +--
>  drivers/target/iscsi/iscsi_target_erl2.c          |   8 +-
>  drivers/target/iscsi/iscsi_target_login.c         |  29 ++----
>  drivers/target/iscsi/iscsi_target_nego.c          |   4 +-
>  drivers/target/iscsi/iscsi_target_parameters.c    |  58 +++++-------
>  drivers/target/iscsi/iscsi_target_seq_pdu_list.c  |  34 +++----
>  drivers/target/iscsi/iscsi_target_tpg.c           |  13 +--
>  drivers/target/iscsi/iscsi_target_util.c          |  11 +--
>  11 files changed, 118 insertions(+), 171 deletions(-)

One of these update suggestions resulted in the commit “target: avoid NULL
dereference in CHAP auth error path” which is considered for integration
into Linux stable versions now.
https://patchwork.kernel.org/patch/10110459/
https://lkml.kernel.org/r/<20171213172230.12767-1-ddiss@suse.de>
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/target/iscsi/iscsi_target_auth.c?id=ce512d79d0466a604793addb6b769d12ee326822


Now I am curious if more remaining change possibilities can be picked up
from this patch series.

* Would you like to improve any more implementation details?

* Do you need additional explanations for further benefits?

Regards,
Markus
