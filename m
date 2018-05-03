Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeECLrM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:47:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751121AbeECLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:47:10 -0400
Date: Thu, 3 May 2018 12:45:59 +0100
From: Roman Gushchin <guro@fb.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 RESEND 2/2] mm: ignore memory.min of abandoned memory
 cgroups
Message-ID: <20180503114553.GA8136@castle.DHCP.thefacebook.com>
References: <20180502154710.18737-1-guro@fb.com>
 <20180502154710.18737-2-guro@fb.com>
 <20180503023142.GA4938@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180503023142.GA4938@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:d1b9]
X-ClientProxiedBy: AM5P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::32) To SN2PR15MB1088.namprd15.prod.outlook.com
 (2603:10b6:804:22::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1088;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;3:hhaCo5vsnhcW6WPY+fov7m50LC6ziLU2/JdI51NZzMNqPrKXqS/uMZZFK/JVirg/u3RUhjmN6yNeHlqXFTVsRLnRbmcgJAgPQsew0O8QQxIgCfsdY+34rX9xuJzQ9BgfgoMIVGOWAHaHiIpvvlJobg1xmhhDQcz39EMBVXp1WfS33yfQ6kSHSLIm4XT2sBOBvYkBDXKYk5RvXxHigfghGpMaR3ByULpockMzm4e+Vx/L5MMVqM87LsBmG3GrONVo;25:H0DW1BlUHnMepblDucJjo2OFEGo6o8KGdOTePzYCYjt/RjR4rHvgYCabFy3bIZ/MEmKVnvS6iLjmUJLzuY1WCFFNSuaEmwwdMmkhQLjsMpUklN19y1z6w9DBsmMf2XtFOLQO7pMt63k2DltTxgFyC+2hZGaAS91238cfN7Rc9IsfppVc2QKISotEv+XR+aZqvNfv5NimBVrcmljbya5JbflrR9sBZb5UTkLNac54iqyEDQr8KD2WIhyXOo8mwHDpEzbLySUzPjAZLUw5W4W1CAq3wovBQ6WJv1f+wS25WF57TamEfw4bANBPCeyRPzyEYRfm4q8bZY+7RL7sVHKOrQ==;31:fmrPkYk1b3kQSpu5i/KOOEm2k3jSmGTkRA8tH6oqM526nfDEJekIRiEIzt9vAzeRSqWtUwjLXmpnqmSqOJd193KPGFFlkqUsX/eXLCygD5yoMavhrKBhaiYsKiURusuQXvdXdF3y+InqfcPuOaYuRhEOUZsNv/1b3ECAT7CiFigQHeChnOLc2Fiu0Ww2Pk2ioX4Tb2KQ9POEi9IJ04HtXI0tSCO4k7AL3HGXkZ1VjTw=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1088:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;20:tndDFg6Es4qU3HaEfRgg46sPZlCFSw57qw/H+/PPcKtN3bvPW93cDQc9f8oFE9wkTM0VuYoFfAUQTLHH0XrFHKLYdiUS5dMMz6tEPMNM6mUoLVAKBWpx6ZwTLu7HtyIbJoLe+fsAq7UFcnke8BIX8j42SZJ02gTNPG7y2+OmB+cinmZkTSBLS3Eooz9xW7Z2pw9UKMHEMjWpLNXu1Ldeue/gKvgfYsly2U4rvvUAmvCv+eUrkGBYNGjz8C+PP14O8bV6k7PC4REhJm8G1yaITW1h+cuP8DAFy4ig9tcD2G7om6j6w22Gc57YUUoyFSXXrYF9NNByzEIlgxhJwBPcwP1rYOQ6rokj9nBSMuVtMdGWW6Mot/45dk5QdpKgz0fTsPFSVTYMLVOrPMqdoB8SMysFRPg2PuYTGTg6C+/TZYhvHwUxhRBvtP0k0Psl+VcBNC/l0KtwMAEp/h0AkGE5K9OZBFmMnKQDjNMiK5kXaFt0PD3N2igxLxAik6fCrZyG;4:cLshAH9+g/hF2YsDdQyS9WqN66Gwt6S5rQohJSYwiwaPCBHVEzBIVBR24TDN8IlOwLKcCJZ/pokEUfmR/XgyUn+6ZCwEvKZXBBwwPirn3wVA4GsMYDPkWp+GZXkge9OfoGjK+dqGl+/5wltE+0W4rtFtXmHNZ4cf8ekRWsoUz5N3FzUrFaMKC8gvvTtfb56hKHzKpb8PqTvwxkSALvJqvUEVd2mgEQ4f+V4mSXqPJX91SsP56kXQXHRiR9+cQ3wJvE9DFZuZGJ40R56wkKa+Eg==
X-Microsoft-Antispam-PRVS: <SN2PR15MB1088DCEF54688AB4A0F4952DBE870@SN2PR15MB1088.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(3002001)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR15MB1088;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1088;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(68736007)(86362001)(305945005)(11346002)(486006)(39060400002)(97736004)(446003)(4326008)(9686003)(478600001)(55016002)(476003)(50466002)(1076002)(6666003)(25786009)(6116002)(2906002)(23726003)(16586007)(47776003)(105586002)(54906003)(46003)(52116002)(58126008)(6916009)(558084003)(81166006)(106356001)(6506007)(8936002)(8676002)(7736002)(229853002)(5660300001)(386003)(53936002)(6246003)(186003)(76176011)(33656002)(81156014)(16526019)(52396003)(316002)(7696005)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1088;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1088;23:JR3BEt02ivjPYyGIaO/DSj15smiq0Ayxpc8Zr2cj+?=
 =?us-ascii?Q?dG+9b27PLrK8lZajlL3zjRVcJDqkxh+6RJPwXXcUIOPxR0rdGmtuhK2QEo22?=
 =?us-ascii?Q?5PGT4qSywSYNUqGE1KxIS3rPoB5EhXmwimYWOAqlZyflavF+dYz0NMoXAhpE?=
 =?us-ascii?Q?CYpdhYLRCihMBPiHgrSUQ8XaEk+um8LXReCNYWUC2I49ibfPfNFhVyOmFEAg?=
 =?us-ascii?Q?JY7KxPbxr2T3E9kTFB3dli5Q3cmNzq+/vPVcU6Q561va2DdeZik0wjYGJkYp?=
 =?us-ascii?Q?X9p+DvJ0vMlP7QSSmZ/6l61sO20ANVpvYE0wblhh2/dbMNH+24rChtCAmCgR?=
 =?us-ascii?Q?WTVu8jU7q7xwhsimTcnnmmhCZuaFsJX7svs9qU9JX/VmQe+nmQ3wwkSsNqRv?=
 =?us-ascii?Q?5oolZV0Q4gdlMax6Inc2Ww+nY3vnlPZFdVE15DjgrPP3fNUHK6WAbOoeCHCT?=
 =?us-ascii?Q?RxRV64cH9pbm1sqVGQJtJUrVEJx7wVkyjIDpn0pDltbaH60gcc9CQmgB/c2G?=
 =?us-ascii?Q?L49CYP+Ww6aeZqjAiglYtQWxZ4Q14vvwjqqVN4NGoeheEP3td1wUZuaGnZ4U?=
 =?us-ascii?Q?+8tI3B7yhXs5w8RKQ8R2umxz2vDz66M5Gsr4SPbuaHvd+YvP6wSB59MipLUf?=
 =?us-ascii?Q?3Bto2EiDXBp5Klw1fRUJhNxNfGmxTBMiCFTXUF1FqreYmgM0k/orJzJrCilH?=
 =?us-ascii?Q?d3QxNdgsvwscvSqUxCCSP6/XGC8JkErs+oncC4l0KEtjuWrQoxF4E2h+CE2H?=
 =?us-ascii?Q?5A12sTDnw2Rag5TriFgf+XxVncMm7HlOqTWUhne3B0v04JuHR79IQ8HfwZkS?=
 =?us-ascii?Q?IhdKxISfDmwrlliRbyV/uWvFEk5KzSCS5jJuRqcRupigANHvGJIpKS5FaCfG?=
 =?us-ascii?Q?XR1kfKrLwOizKrxTp46qo66bJKmxkWz6Y6qkSn6+bRKc2p2Yi656sK/L5vh9?=
 =?us-ascii?Q?mIfsSFFuLr0n1PVW1Ad9GPS+QiNfXmdrIFUrIv6ZkC7DHSFtlIpc+iWDXSy7?=
 =?us-ascii?Q?9a09JBOxqDE9BWLXxmcrcQIFCIRQzV6ixA0y0NZthLBV+UUaicrsOFAoAdJY?=
 =?us-ascii?Q?oGgnWOJDnGyvEm1zID08oXTzcLslgaHz4KFWRGCQCcJILvVzhqFVtBr4AzXH?=
 =?us-ascii?Q?SHIhCOM1W24f2bb2/i+2lq2IhcFSCSDgbMStwUuymbyswveV7fOtwmx32OHq?=
 =?us-ascii?Q?OzncU5QPaLkj0sQ1PvbY5PEldLbX0mGRqbF287jtA8dCjTsCRkH8DIMlMccL?=
 =?us-ascii?Q?9EVzgc81u4dHLvPHyRq69cH5hibDImBU6sna8f3Og6R5oBTTZ8kFA8A4q1aK?=
 =?us-ascii?Q?mW8F+Zj52jcNC4AKZYqhp0=3D?=
X-Microsoft-Antispam-Message-Info: NNgmY+wA6lSjP8KDK82b4TwXYigds8/LNTZE/TK5CF/JQAiuWsEl9kfRu6ukq9BPlSPjxasFSEexTYMxU3mezm5MRB/A8RqTxP/zWToquiirFzNO0ib/S49bomjqMPAVr0yRqimCVr02CyxXY1BCT06insCylbRAsG+HUODrhN+ZhdgcOcA8UHkNNzBcU5uR
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;6:yatRKI6KuwFY1HcwuJNMeWuPYN91Hzca8Vdr5oTykAaoBSXkRIMK0VWYJugVRWEkoa8Cue2M0RhCpxcH9EXvzx38L757zXaEGTlDEGYULVvAWTRFP1QK0qTy1m6ExnvcMwMmoNQ3Rhe2YIKJLYKMv2HTZp+nxxfh5D8bGdx1xDRHw5HBlsoU/JOF19fvAHQ3D6A8eG5FRLoRCjlXAl2dCcVxjJNGvvFwxledGHFn/EqJA4e2cy5JBhxsmIQmw2feBemttELUmkGxPPYGlmv8MaJGroMQICAZ0fkXGvAEnMinvcuwRQ2a6Lc11sAquzFezAyYRQNoD0BsaAaurVV3OLsa3cX3O9o+UutHaP1SSWRvHfpr8GsaWxrCX8h0K9fqBlbRjyp54icI3ZVnfpwKZct8iqgHyhL9FsVLfNxZeCwqFoUMxe445W3F3MSnkhuSUZJYJBCPloFFAabliZqjkQ==;5:PAzlWmsFJi8BpN9ZAYOukSc6D9X2apImwWHsAGyyHlrDr6syztTlL1/rseJTTHRJcwQFUtGkY103WTjPnnoqXzFELV2KyiSoR5ufEV0X4kKIawRoKKbsUugTkZQ+zXWwAdT08STyxFUctLTaUmJ+hyQ31QL5Pw8SxlosyHTiLdw=;24:AXxxV34d8S8ebBBnY+lFyDfRvZmPnbl2GNy5H/0dtQK+qHy9R4w2v32SXD5qxJoY1Ftph4KBoH0HiUQ+YQc2QhPSHhrshe888U170VbYkDo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;7:Ffx9sHc+NBEKns6FoP9xuBxtcd95fKttEbmvWG00DwxraHOadyQH4UkfXxci0I54uYhqPQRxq8N2zgXXzhAxXVW7C60+vexFHnTIFwqF8+1/2hYngonR+f5tjAMq64fVGO4FjBJXJHJb9gMPu8SmKEx0ejsvICVE7J3hhpZOJiOfog4U2TZMm9rI+WfKj0L7OOOwTq4ZrSsRw264sb6JYrN+Prc6bpkMMwKifxaFKTkp1S2/pAJHvZ6/RMYr5AvB;20:1TEoHqIc3wAO2Nt0ibazud/YJ81+XkLZ1bOYxBMZH40rfzk89+uHtC1WdzMB6Nv8MBgwV+AeCXv3LX4kk4LSETmr5ZR2fREDka76W52b9pOyoGS4BHzrbaiklZ7kmpfYzt7Re/jIMSexo9FdLnt+061L+SSqWbcIfo4eJn5JVew=
X-MS-Office365-Filtering-Correlation-Id: 425a315a-53b0-4a77-709e-08d5b0eb7934
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 11:46:12.5231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425a315a-53b0-4a77-709e-08d5b0eb7934
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 07:31:43PM -0700, Matthew Wilcox wrote:
> On Wed, May 02, 2018 at 04:47:10PM +0100, Roman Gushchin wrote:
> > +				 * Abandoned cgroups are loosing protection,
> 
> "losing".
> 

Fixed in v3.

Thanks!
