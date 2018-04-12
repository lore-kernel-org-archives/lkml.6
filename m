Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeDLSbO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:31:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40864 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeDLSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:31:13 -0400
Date: Thu, 12 Apr 2018 14:30:52 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, jgross@suse.com,
        iurii.konovalenko@globallogic.com, tiwai@suse.de,
        Oleksandr Grytsov <oleksandr_grytsov@epam.com>
Subject: Re: [PATCH RESEND] xen/sndif: Sync up with the canonical definition
 in Xen
Message-ID: <20180412183052.GS350@char.us.oracle.com>
References: <20180412172627.18065-1-oleksandr_andrushchenko@epam.com>
 <f3135104-f480-e1e8-0628-136bf265c2f6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3135104-f480-e1e8-0628-136bf265c2f6@oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8861 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 01:46:33PM -0400, Boris Ostrovsky wrote:
> On 04/12/2018 01:26 PM, Oleksandr Andrushchenko wrote:
> > This is the sync up with the canonical definition of the sound
> > protocol in Xen:
> >
> > 1. Protocol version was referenced in the protocol description,
> >    but missed its definition. Fixed by adding a constant
> >    for current protocol version.
> >
> > 2. Some of the request descriptions have "reserved" fields
> >    missed: fixed by adding corresponding entries.
> >
> > 3. Extend the size of the requests and responses to 64 octets.
> >    Bump protocol version to 2.
> >
> > 4. Add explicit back and front synchronization
> >    In order to provide explicit synchronization between backend and
> >    frontend the following changes are introduced in the protocol:
> >     - add new ring buffer for sending asynchronous events from
> >       backend to frontend to report number of bytes played by the
> >       frontend (XENSND_EVT_CUR_POS)
> >     - introduce trigger events for playback control: start/stop/pause/resume
> >     - add "req-" prefix to event-channel and ring-ref to unify naming
> >       of the Xen event channels for requests and events
> >
> > 5. Add explicit back and front parameter negotiation
> >    In order to provide explicit stream parameter negotiation between
> >    backend and frontend the following changes are introduced in the protocol:
> >    add XENSND_OP_HW_PARAM_QUERY request to read/update
> >    configuration space for the parameters given: request passes
> >    desired parameter's intervals/masks and the response to this request
> >    returns allowed min/max intervals/masks to be used.
> >
> > Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > Signed-off-by: Oleksandr Grytsov <oleksandr_grytsov@epam.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > ---
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
