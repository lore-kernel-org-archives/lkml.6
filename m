Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeDMHJ0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:09:26 -0400
Received: from mail-ve1eur01on0111.outbound.protection.outlook.com ([104.47.1.111]:34272
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750973AbeDMHJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:09:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioan.nicu.ext@nokia.com;
Date: Fri, 13 Apr 2018 09:09:18 +0200
From: Ioan Nicu <ioan.nicu.ext@nokia.com>
To: Alexandre Bounine <alex.bou9@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Barry Wood <barry.wood@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Frank Kunz <frank.kunz@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix rio_dma_transfer error handling
Message-ID: <20180413070917.GA2794@nokia.com>
References: <20180412150605.GA31409@nokia.com>
 <20180412142803.cd235a40155503700dc73b21@linux-foundation.org>
 <d77db0b1-2cca-c0f6-987d-32ffb45cb16f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77db0b1-2cca-c0f6-987d-32ffb45cb16f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [131.228.32.189]
X-ClientProxiedBy: AM0PR0102CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::31) To DB6PR07MB3286.eurprd07.prod.outlook.com
 (2603:10a6:6:21::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:DB6PR07MB3286;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3286;3:auwOPmv92JawRBYC+FEpkyloVB/p2/0FpCUvNRIZlor8o4xpGC3tYoJ5F3U5B9e1+xxX0lI8rhS5XmoaPKrhl8qbuVHWtucVhVoKM+tszV1Ko6ryf3mx9a2MRZweUICJBC+z74lqnLEKvZ9mrS+PXYsdN8/UWiUsPWd//31zoKb9dTc1JRWl26cyJLjGC6Q3SwQDi/SBzEmYdJD52m2iXplF5/kygJECqtYQmB893/hUi61P+YqTOkj+UXNc0bi4;25:uXkEiATvrPvArorBFEzkw+I9d3/Y8YDiE7WZsTHq6B8ozxMc2+YUJsWPFdwf1vc+NylOqjXjb5QkSnshBrn8GH6PMG7NBcJgzF6mkTDKsK+jNEIeXhptCFk2Ee9JqdFWeWF6hQn82AKeP42nEMsL0zn0vkQ+igkPYNDeoppPtES9kS1MdZBdBWLS6WFew1FvvCYUvAauaacPI92C0MYIh6CwLKRnu0DkW7iTylzffPWeB12qQ8euuqG3KlDYd9yfOxIeTDEEHXvFD7sFOYq2vRKHBlmEGmZbchDFZ5oalqPEkc8KJbPmlz82ifCrkXUP6h7LFcTvERgwtx6llw4XKQ==;31:bg/ewDxxszgfGcGhiTgLwzxZ/lvutmHBD2S8YQNn0krAZwTuQQJkq58Ys4Zv87enzVi0M4i1koWKjKrcH7xmMo/OLU7Dc8uSGcVxLueHYgjPWToyrplSCbtqppQyCYHNGSerdI9y1GE+bCDDg2lWqgnw/cjBdatHA4EtSK3rAMjWXeJEpHgtFbYZi5FLgDExuZy+GABF/N9SPmzG2n2GAuuuu+1iN4IFZHbYCxtcOMg=
X-MS-TrafficTypeDiagnostic: DB6PR07MB3286:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3286;20:y4WNIAL6+jaT4sgp8nCKegYPraAN8lNBDKo1v6UtnQiLa3fcIAnLyuoeUua7oPRvF7CFXoh/IVXOAQ86/MAkVN1U+buLX2Hus3ODyIY21zPtbqPNCkinpKSxdy6Jgtpb02Qz+AfYixwXKd4LR8xJB6U8WN0RpOmWDckBhQ8nHRT1Y5e2HkkFuvk0BNtKxdVcBjm4d4SMLxz5po0/EQ8YkVXfPfYcIt4SeqcOweFyZlPXjRs4xdDhzuPg7lPTUFioorv0chqsGG+tFhKYFkHel34rNHkYW7LC55R4+i5xj1sh+L3BShBS9fWjn8CCqRwMmurd4FVjV52tkr57HHJNobYtbZKNrsN2a12nFvx6pwnjtxLyjf0j46NsxVjvs5HPNpLtUsEZg+6BAk3nnFgEphnFpfXx5LEJbuTCSN6tftnzi1NmLBo5oahp5BSw+YFJdNzoPMg3u3bJ2ovT4/b18C7yrGKjeKmLtYyYnXRt4wgbwJWpYvAbePIxt6DTbykI;4:FWsZM9SAwL2kioZ5o42U6yUxPmKXbWxeYc8wtd7BBWLHv6vmr/U56dvE0DhaTxgWdivKzxhVOj7knOgPVcu0cIy88l8BwYs+OKvjcNzCjLvH7LYTcc8ZitouLouWJ60kFljO0a3nwdzDiezVz/m/nlYZn7ll3wJe2YZ5oznwZXiouvtjd/8OitFNO46QuiSaRkFBoVHuhiDeqP2G1KWhvi43dnAHIEEhbOP85l/fxIIh1TbSDUaxnoJTi2srzBhbaGi0r6iuzdEkS7aDKfB/JwBxuRStBI8RFPGPOg+M6bcY9vpNylrwik1hie9W7K87/1iTvyJhyAJ/VcpxRCfLl8XqZqD42fDGCp9XJnUMcFM=
X-Microsoft-Antispam-PRVS: <DB6PR07MB3286722F98B3EF3A44F58A8BA6B30@DB6PR07MB3286.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(11241501184)(806099)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR07MB3286;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3286;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(377424004)(69596002)(16526019)(23726003)(1076002)(4326008)(3846002)(316002)(6116002)(36756003)(33656002)(39060400002)(58126008)(54906003)(478600001)(50466002)(106356001)(6246003)(476003)(5660300001)(305945005)(53936002)(25786009)(105586002)(186003)(2616005)(956004)(11346002)(16586007)(446003)(7736002)(7416002)(26005)(8676002)(229853002)(7696005)(52116002)(97736004)(76176011)(53546011)(486006)(21086003)(68736007)(59450400001)(47776003)(8936002)(81156014)(55016002)(86362001)(2906002)(66066001)(6916009)(386003)(81166006)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3286;H:nokia.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR07MB3286;23:DHPoktcwgyHwGdICwqkbsZ1aB4a4vIX3JpUzx5tcD?=
 =?us-ascii?Q?UtdXcR2ZzkId7yvvHOSJgc+yS0eVn2BivZNKpzjf61cFzea3Oi8UKW9A9wQp?=
 =?us-ascii?Q?DOcpEH6Iz92fceUGajhK4Zy00h7dGMFX3c1NRKxnBH18Ows/o+dzJyiuVWHx?=
 =?us-ascii?Q?09JXIp5B1ZVuhOmP4v4tnlnC0CpP2IiQqtvXLswHE1UO8HEx3AoBXoT7kZv7?=
 =?us-ascii?Q?eDZDxYKiK4hZvVMPDk06rB8zxIZZ7gpJ6pDO3A8/O0DsjfkMusZkLWbPA2Ie?=
 =?us-ascii?Q?75W++dOsOwoo0qKhHSc9t8sdajnmB8gw4eud324maAHXrD47uZylnNrh3JtZ?=
 =?us-ascii?Q?I60rCWF7ungGMGFByDp5mFuX+iVrl2XwYnHE4J89r6oaO9+EoHVDJ1HI40UC?=
 =?us-ascii?Q?PpSj6+Sp+l8g44qkpwKaia99u2Pky29rXNZ7Kp3wMSSkHR05fWhY2uRzwE77?=
 =?us-ascii?Q?W1+IXsTa9qy+jUI2hTVxYGEFClEdFKVyXE9+SdxdIGrDQ0uFyRGWiXPgWvX+?=
 =?us-ascii?Q?R881f4e2Jd9VqCQb56P1xukSul+ct8AUZOCr/VBe6r2az2Dz8ENn3OwkTYXp?=
 =?us-ascii?Q?GuIubMELkdSQjwgv1FJaMPytCTWPLL2a+sht88GGZFyvBLvtkpDZcvNtLU2+?=
 =?us-ascii?Q?rDiP1RrA0YqsszPl2G3+kGTC/UERJ+Yru3HA5KJ5FCKyZg8J404Jt6uo46oS?=
 =?us-ascii?Q?Cdno/qsqTKHcn+BeDREWDcpujbkWRqXe95hvFLARh4pq4kn5Eswk+vdD8nfO?=
 =?us-ascii?Q?4cPYI0hu3W95JSNY2BSNUls86JBhz/JhDLfW76wgzuRAsMdgtQ+sz+xQSZbG?=
 =?us-ascii?Q?4VIPUgwnCsFW2S5hhbUn1Y9zRZ310j90iLb0JKgPpcOyOd/7/gsJwT4/HmcC?=
 =?us-ascii?Q?DHA2CpBMUKfJTTH9+PSSbfleteSd8T1O7s7TBbmEKGZQipP87VHLx5sMw3zS?=
 =?us-ascii?Q?wdEfLTAcmWTNucwlt0+9UGG9hDHo0RhUQNxD/jDqGCvnvRQxHgNTC6NZ0ITU?=
 =?us-ascii?Q?ReHoQGY3MlgSJR1nrT5J9PYFbGP7HFai4tAoUvNVQTEH312TBRz0GDjTrus/?=
 =?us-ascii?Q?QPSgRFxov8ejTF4ED7EQDPWETJ4d4sMdDdXhG8ynA8T72ZnQE0lfSLFL6A2n?=
 =?us-ascii?Q?j5FTYdjpAUoWlHZM/yhQ5GG2/rpndq3f4Xsv2vblsgz62tnB24cDddGOYVcz?=
 =?us-ascii?Q?W9bBRxBCmcTOfIojoHBpBN+O++7MbyEWv1YeLFkCnQsj3PqaYGYZt6fMhaNI?=
 =?us-ascii?Q?IJL0Z+ldJKoW5J+M+JVVhtIxJyOffq5JQfqKe9+wun35uzKWYB72+aT2BjfA?=
 =?us-ascii?Q?yZwa/m5WBjajzuMCeSpd9efTA3baVcXSgLhC44Z6FKf50BwwdDXaBq8TU0Qv?=
 =?us-ascii?Q?KkJ9OhEHxyR8l+6qJYhWfRTf/GsCnNQd8C+tmCW6EERFi+LMUrn6gWtQi7m0?=
 =?us-ascii?Q?tMHNcRzdQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3286;6:StcWT7e46q1UjLo6XEUCwXA2V9g285jyQ1VuCIvr3ezta/liNpO0TzbQLpN/PK3ONoR1hzSIkSKXBGDLlI+HSHzv7IlKYl6OcVQn/Tbt/o3a565ZC+oBBs3bggfYciYKxLb6Mzdn9nedUmyrWu4TPdGO8Qd1ZypAqCAtTxs65VihhpTVTX1svSTYI2ZiAdmRXN3ATMtCX4y5bNmIo7oQQf5JIeLaYNND5uWgVbB/vuxyIZx0r/2xPu5d8KbLjZumlD7jMj4/NKF9KdkmFiijDsMZwpcxRDoMGUA3m2VBgw2LB7tEhBXQRumV2ib9Rzj4Mh05dhIfEXvrUleJumyuYIhM16zIACQoprbfeGcFznudzMxDm0sMoEZOIrm3z6GVBinv0w5ieqzcKw2NSLA+8NgurzH2nHgG4byfdHoP1xxpoi3nbhj/VTvIieb/udpTTiV+BeFk+JkzCYhgKCqiJQ==;5:jvNB8pqgk3xrjeapVP5kNxywRcJV9QQYke7TUfP6ZZ7e7WhGAhCkBdbaK9hQurQMt4290Ree0tH7qbCXlrtXkLN3FxRy1AGxwYIv1RsRIiCHjRUxCy8dw1ijMImUh578vIcpAPCYgG24ORR8FugwedImRr5cWOt8IrEZAr8VkCY=;24:J2Pw542UMo6GhWXwhMtQ6IH7RG1T9lltVv4SO06gtNC7lexSwn2NwycwD5spgj0sfbekVknSZKCEMJGHckIfkT4OyIx8UcMuh2I53mfiRAE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3286;7:TwI3LXOjLLWHcSDnouInpSc6+PLG5iO+gy93Qoth3x9dahl/K80ZngiGXwL1hhLZL0gU5CFunF/solrDTNhFGbAt+DFNOTUWWq4aiMViLFSvQnUjLZOdQkFDoqqM/WQLrWMvbmEh2jIrYfLJHEXOO54OPl0+xBf3jlw14k9BO1X/eaD2ZGIXt2yPi8siW2vijNZtIc038TvDmIKUewEFY0abSc7rPWEy1BwWg8lJzV53N3rrlsNa+8Zs9DMtHVGy
X-MS-Office365-Filtering-Correlation-Id: c4abbf8f-e070-4f5b-eb2c-08d5a10d7b0d
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 07:09:20.3102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4abbf8f-e070-4f5b-eb2c-08d5a10d7b0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3286
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 12, 2018 at 07:44:01PM -0400, Alexandre Bounine wrote:
> 
> On 2018-04-12 05:28 PM, Andrew Morton wrote:
> > On Thu, 12 Apr 2018 17:06:05 +0200 Ioan Nicu <ioan.nicu.ext@nokia.com> wrote:
> > 
> > > Some of the mport_dma_req structure members were initialized late
> > > inside the do_dma_request() function, just before submitting the
> > > request to the dma engine. But we have some error branches before
> > > that. In case of such an error, the code would return on the error
> > > path and trigger the calling of dma_req_free() with a req structure
> > > which is not completely initialized. This causes a NULL pointer
> > > dereference in dma_req_free().
> > > 
> > > This patch fixes these error branches by making sure that all
> > > necessary mport_dma_req structure members are initialized in
> > > rio_dma_transfer() immediately after the request structure gets
> > > allocated.
> > 
> > This sounds like something which someone has actually triggered in a
> > real-world situation.  So I added a cc:stable.  Please let me know if
> > that was inappropriate.
> > 
> > And please remember to always include all information regarding
> > end-user impact when fixing bugs.
> > 
> This bug fix is applicable to versions starting from v4.6

Actually, this is something I broke with my previous patch where I added a
kref to the mport_dma_req structure. Before this patch, all the error paths
were doing kfree(req) instead of kref_put(&req->refcount, dma_req_free).

Now that dma_req_free() is called, it dereferences req->dmach, which is
initialized late in do_dma_request(), so dma_req_free() could be called
with a NULL req->dmach in some cases.

Sorry if I did not make this clear enough in the description.

Regards,
Ioan
