Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeDPPKZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:10:25 -0400
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:59860 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751099AbeDPPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:10:24 -0400
Date: Mon, 16 Apr 2018 10:10:20 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v3 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <20180412191322.GA21205@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804161009590.8424@nuc-kabylake>
References: <20180411060320.14458-1-willy@infradead.org> <20180411060320.14458-3-willy@infradead.org> <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake> <20180411192448.GD22494@bombadil.infradead.org> <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake>
 <20180411235652.GA28279@bombadil.infradead.org> <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake> <20180412142718.GA20398@bombadil.infradead.org> <20180412191322.GA21205@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfLGxPMy/Noi9QztCI8seSVlPMuW+vtUlus2sWjnmzYHlTjgvr9/JqQ4xFkuPscbhASy8a7CO7BoNVfptXl2i6jZZDK73ooxSjoBNHQVUDXFsW/HIh086
 X53mm4/NlGuPFo3U4YdjVClvoXtRUq/RUQHsn5b8MJzJVAhth+4UPH561BAqZh1BJ4JHJBsAMJYQrDOESZGkygXX0ltc0LPaAa19nD5YU+VxZ20zna931pO7
 6ygy42FNFCrB6gNWOij/4Fz4NZeS6GM29n/hwUMoqLMAeyM0N8D/1lblLeUJDM3hE5Zr97Vf/s3X3L4WEaF1T33TlyrY/95Jylr4xTAXYuvIDcxd8Q8jCsZR
 XrmLCWTTEJlDcFXtJH5htp99qePwLs5vi3J7TalNb29jAsqm0q1acbrp2aL/8k4ovniaOjH3dLJwJVU9Tt0en4l0Igb6zTZlnX2Sk4Z5pEZussaoRgR9npg4
 U5aMMjiygzCM5P+c
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018, Matthew Wilcox wrote:

> __GFP_ZERO requests that the object be initialised to all-zeroes,
> while the purpose of a constructor is to initialise an object to a
> particular pattern.  We cannot do both.  Add a warning to catch any
> users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> a constructor.

Acked-by: Christoph Lameter <cl@linux.com>
