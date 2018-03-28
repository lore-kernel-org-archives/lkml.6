Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeC1Voo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:44:44 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:39911 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeC1Von (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:44:43 -0400
X-Google-Smtp-Source: AIpwx49y75FFW/LTDwnmk6ikJ6PiTlR4zYC3HzA9/xlw/GdHij+kXadv1udfucVYc/+IGjRU0caBEg==
Date: Wed, 28 Mar 2018 23:44:38 +0200
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v7 0/2] hid-steam driver with user mode client dection
Message-ID: <20180328214438.GA5740@casa>
References: <20180325160703.15997-1-rodrigorivascosta@gmail.com>
 <CAO-hwJ+XxB9QnZSAALPZTWmAMDsrzq-dhjtMDOvdXHWtDv=H7g@mail.gmail.com>
 <20180328181448.GA1674@casa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328181448.GA1674@casa>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 08:14:48PM +0200, Rodrigo Rivas Costa wrote:
> On Mon, Mar 26, 2018 at 10:12:19AM +0200, Benjamin Tissoires wrote:
> > Also, I think there will be races if a user changes the value of the
> > parameter while running the system. You might want to add an
> > additional patch that would trigger the mode change on module
> > parameter change.
> 
> True, but the races should be easy to remove, with a simple local
> variable.  About the trigger, I've never seen a trigger on module
> parameter change. Can you give me a hint or example of how to do that?

Never mind, I've found it: module_param_cb().
Moreover, I'll have to keep a global list of steam_devices, just in case
the parameter is changed...

Regards.
Rodrigo
